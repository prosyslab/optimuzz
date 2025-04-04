#include "llvm/Analysis/CFGPrinter.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Value.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/GraphWriter.h"
#include "llvm/Support/raw_ostream.h"

#include <fstream>
#include <map>
#include <queue>
#include <set>
#include <sstream>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include <cstdlib>

#ifdef __clang_major__
#define LLVM_VERSION                                                           \
  (__clang_major__ * 10000 + __clang_minor__ * 100 + __clang_patchlevel__)
#endif

namespace llvm {
class TrackPathsPass : public PassInfoMixin<TrackPathsPass> {
private:
  std::unique_ptr<llvm::raw_fd_ostream> CFGFile;

public:
  TrackPathsPass();

  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
  static bool isRequired() { return true; }
};
} // namespace llvm

using namespace llvm;

static std::string TargetFile;
static std::string OutDirectory;
static bool Verbose = false;

TrackPathsPass::TrackPathsPass() {
  TargetFile = std::getenv("TARGET_FILE");
  OutDirectory = std::getenv("OUT_DIR");
  if (const char *VerboseEnv = std::getenv("VERBOSE"))
    Verbose = std::string(VerboseEnv) == "1";

  if (Verbose) {
    errs() << "OutDirectory: " << OutDirectory << '\n';
  }
  sys::fs::create_directories(OutDirectory);
}

/* From aflgo-pass.so.cc */
static void getDebugLoc(const Instruction *I, std::string &Filename,
                        uint32_t &Line, bool HandleEmpty = false) {
  if (DILocation *Loc = I->getDebugLoc()) {
    Line = Loc->getLine();
    Filename = Loc->getFilename().str();

    if (Filename.empty() && HandleEmpty) {
      if (DILocation *oDILoc = Loc->getInlinedAt()) {
        Line = oDILoc->getLine();
        Filename = oDILoc->getFilename().str();
      }
    }
  }
}

static int GetBBNumber(BasicBlock *BB) {
  Function *F = BB->getParent();
  int Count = 0;
  for (auto &B : *F) {
    if (&B == BB) {
      return Count;
    }
    Count++;
  }
  assert(false && "BB not found");
}

DebugLoc GetFirstDebugLoc(BasicBlock &BB) {
  for (auto &I : BB) {
    if (auto Loc = I.getDebugLoc()) {
      return Loc;
    }
  }

  // Find the location from predecessors
  for (BasicBlock *Pred : predecessors(&BB)) {
    // reverse order
    for (auto &I : reverse(*Pred)) {
      if (auto Loc = I.getDebugLoc()) {
        return Loc;
      }
    }
  }

  errs() << "No debug loc found\n";
  return nullptr;
}

void InstrumentBasicBlock(BasicBlock &BB, FunctionCallee CovFn) {
  Value *PathID = ConstantInt::get(Type::getInt64Ty(BB.getContext()),
                                   reinterpret_cast<uint64_t>(&BB));

  IRBuilder<> Builder(&BB, BB.getFirstInsertionPt());

  DebugLoc BBFirst = GetFirstDebugLoc(BB);
  Builder.SetCurrentDebugLocation(BBFirst);

  CallInst *CovCI = Builder.CreateCall(CovFn, {PathID});
#if LLVM_VERSION >= 180000
  CovCI->addAttributeAtIndex(AttributeList::AttrIndex::FunctionIndex,
                             Attribute::NoInline);
#endif

  std::string FileName;
  uint32_t Line;
  getDebugLoc(BB.getFirstNonPHI(), FileName, Line);
  FileName = FileName.substr(FileName.find_last_of("/\\") + 1);
  std::string FuncName = BB.getParent()->getName().str();

  const int BBNumber = GetBBNumber(&BB);
  std::string BBName = FileName + ":" + FuncName + ":" + std::to_string(Line) +
                       ":" + std::to_string(BBNumber);
  if (Verbose)
    errs() << "Instrumenting: " << BBName << "\n";

  BB.setName(BBName);
  if (!BB.hasName()) {
    Twine t(BBName);
    SmallString<256> NameData;
    StringRef NameRef = t.toStringRef(NameData);
    MallocAllocator Allocator;
#if LLVM_VERSION >= 180000
    BB.setValueName(ValueName::create(NameRef, Allocator));
#else
    BB.setValueName(ValueName::Create(NameRef, Allocator));
#endif
  }
  if (Verbose)
    errs() << "Instrumented: " << BB.getName() << "\n";

  // Output (BBName) -> all possible (Filename, Line) pairs
  std::string TargetBlocksFileName = OutDirectory + "/target-blocks-map.txt";
  std::ofstream TargetBlocksFileStream(TargetBlocksFileName,
                                       std::ios_base::app);
  for (auto &I : BB) {
    if (auto Loc = I.getDebugLoc()) {
      uint32_t InstrLine = Loc->getLine();
      std::string InstrFileName =
          Loc->getFilename().str().substr(FileName.find_last_of("/\\") + 1);
      if (!FileName.empty() && InstrLine != 0 && Line != 0)
        TargetBlocksFileStream << FileName << ":" << Line << " "
                               << InstrFileName << ":" << InstrLine << "\n";
    }
  }
}

StringRef GetFunctionName(Function &F) {
  if (DISubprogram *SP = F.getSubprogram()) {
    return SP->getName();
  } else {
    return F.getName();
  }
}

static std::vector<BasicBlock *> FindTargets(Module &M, uint32_t TargetLine) {
  std::vector<BasicBlock *> Targets;

  for (auto &F : M)
    for (auto &BB : F)
      for (auto &I : BB) {
        if (DILocation *Loc = I.getDebugLoc()) {
          uint32_t Line = Loc->getLine();
          if (Line == TargetLine)
            Targets.push_back(&BB);
        }
      }

  return Targets;
}

static bool
IsTargetFile(const std::string &FileName,
             const std::vector<std::pair<std::string, uint32_t>> &Targets) {
  return std::find_if(
             Targets.begin(), Targets.end(),
             [&FileName](const std::pair<std::string, uint32_t> &Target) {
               return FileName.find(Target.first) != std::string::npos;
             }) != Targets.end();
}

namespace llvm {
// From aflgo implementation
template <> struct DOTGraphTraits<Function *> : public DefaultDOTGraphTraits {
  DOTGraphTraits(bool isSimple = true) : DefaultDOTGraphTraits(isSimple) {}

  static std::string getGraphName(Function *F) { return F->getName().str(); }

  std::string getNodeLabel(BasicBlock *Node, Function *Graph) {
    if (Verbose)
      errs() << "getNodeLabel " << Node->getName().str() << "\n";
    if (!Node->getName().empty()) {
      return Node->getName().str();
    }

    std::string Str;
    raw_string_ostream OS(Str);

    Node->printAsOperand(OS, false);
    if (Verbose)
      errs() << "getNodeLabel " << Str << "\n";
    return OS.str();
  }
};

void InstrumentFunction(Function &F, FunctionCallee CovFn) {
  StringRef FuncName = GetFunctionName(F);
  if (FuncName == "___optmuzz_coverage") {
    return;
  }

  if (Verbose)
    errs() << "[InstrumentFunction] " << F.getName().str() << " in "
           << F.getParent()->getSourceFileName() << "\n";

  for (const auto BB : nodes(&F))
    if (!DOTGraphTraits<Function *>::isNodeHidden(BB, &F))
      InstrumentBasicBlock(*BB, CovFn);
}

static bool ToSkipFunction(const Function &F) {
  SmallVector<std::string, 16> BlackStartList = {
      "asan.",  "sancov.", "__ubsan_handle_", "free",       "malloc",
      "calloc", "realloc", "__gnu",           "___optmuzz", "__cxx_global",
      "llvm.",  "__cxa_",  "__clang",         "__assert",   "operator"};

  auto FuncName = F.getName();

  for (auto &S : BlackStartList) {
#if LLVM_VERSION >= 180000
    if (FuncName.starts_with(S))
      return true;
#else
    if (FuncName.startswith(S))
      return true;
#endif
  }

  return false;
}

static bool IsInTargetFile(const Function &F,
                           const std::string TargetFileName) {
  std::string FileName = F.getParent()->getSourceFileName();
  return FileName.find(TargetFileName) != std::string::npos;
}

PreservedAnalyses TrackPathsPass::run(Module &M, ModuleAnalysisManager &AM) {
  // If the file is not in the input target list, skip the instrumentation
  std::string FileName = M.getSourceFileName();

  // Only instrument if TargetFile is a substr of FileName
  if (FileName.find(TargetFile) == std::string::npos) {
    return PreservedAnalyses::all();
  }

  // Construct instrumentation function
  LLVMContext &Ctx = M.getContext();
  FunctionCallee CoverageRecorder =
      M.getOrInsertFunction("___optmuzz_coverage", Type::getVoidTy(Ctx),
                            Type::getInt64Ty(Ctx)); // basic block ID

  // Collect target functions (in order to extract their CFGs)
  std::vector<Function *> FunctionsToInstrument;

  for (auto &F : M) {
    if (ToSkipFunction(F))
      continue;
    llvm::errs() << "Function: " << F.getName() << "\n";
    if (IsInTargetFile(F, TargetFile)) {
      FunctionsToInstrument.push_back(&F);
    }
  }

  // Extract CFGs of target functions
  for (auto F : FunctionsToInstrument) {
    std::string FuncName = F->getName().str();

    if (F->empty())
      continue;

    InstrumentFunction(*F, CoverageRecorder);
    std::hash<std::string> StringHasher;
    std::string Graph;
    raw_string_ostream GraphOS(Graph);

    // SAFETY: instrumentation must be done before graph generation
    WriteGraph(GraphOS, F, true);
    std::string Filename =
        OutDirectory + "/cfg." + std::to_string(StringHasher(Graph)) + ".dot";

    assert(!sys::fs::exists(Filename));

    std::error_code EC;
    raw_fd_ostream CFGFile(Filename, EC, sys::fs::OF_Text);
    if (EC) {
      errs() << "Filename: " << Filename << "\n"
             << "Error opening file: " << EC.message() << "\n";
      exit(1);
    }

    WriteGraph(CFGFile, F, true);
  }

  std::vector<std::pair<std::string, std::string>> CallEdges;

  // Read call instructions to construct the call graph among target functions
  for (auto F : FunctionsToInstrument)
    for (auto &BB : *F)
      for (auto &I : BB)
        if (auto CI = dyn_cast<CallInst>(&I))
          if (Function *Callee = CI->getCalledFunction()) {
            if (ToSkipFunction(*Callee) || !IsInTargetFile(*Callee, TargetFile))
              continue;

            std::string CallerAddr =
                std::to_string(reinterpret_cast<uint64_t>(&BB));
            auto Edge = std::make_pair(BB.getName().str() + ":" + CallerAddr,
                                       Callee->getName().str());
            CallEdges.push_back(Edge);
          }

  // Output the call graph

  std::string CallGraphFilename = OutDirectory + "/callgraph.txt";
  std::ofstream CallGraphFile(CallGraphFilename, std::ios_base::app);
  for (auto Edge : CallEdges) {
    CallGraphFile << Edge.first << ' ' << Edge.second << '\n';
  }

  return PreservedAnalyses::none();
}
} // namespace llvm

extern "C" ::llvm::PassPluginLibraryInfo LLVM_ATTRIBUTE_WEAK
llvmGetPassPluginInfo() {
  llvm::errs() << "LLVMFuzzer instrumentation pass\n";
#ifndef LLVM_VERSION
  llvm::errs() << "LLVM_VERSION NOT SET\n";
  exit(1);
#else
  llvm::errs() << "LLVM_VERSOIN: " << LLVM_VERSION << '\n';
#endif
  return {LLVM_PLUGIN_API_VERSION, "LLFuzzInstPass", "v0.1",
          [](PassBuilder &PB) {
            PB.registerOptimizerLastEPCallback(
#if LLVM_VERSION <= 130000
                [](ModulePassManager &MPM, llvm::PassBuilder::OptimizationLevel Level) { MPM.addPass(TrackPathsPass()); }
#elif LLVM_VERSION < 200000
                [](ModulePassManager &MPM, OptimizationLevel Level) { MPM.addPass(TrackPathsPass()); }
#else
                [](ModulePassManager &MPM, OptimizationLevel Level, ThinOrFullLTOPhase Phase) {
                  MPM.addPass(TrackPathsPass());
                }
#endif
            );
    }
  };

}