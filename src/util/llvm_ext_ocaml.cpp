#include <assert.h>

#include "llvm-c/Analysis.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/ModuleSlotTracker.h"
#include "llvm/IR/ReplaceConstant.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Transforms/Utils/Cloning.h"

#include "caml/mlvalues.h"
#include "caml/memory.h"

using namespace llvm;

value to_val(void *ptr)
{
  assert((((value)ptr) & 1) == 0 &&
         "OCaml bindings assume LLVM objects are at least 2-byte aligned");
  return ((value)ptr) | 1;
}

void *from_val(value v)
{
  assert(Is_long(v) && "OCaml values representing LLVM objects should have the "
                       "low bit set so that the OCaml GC "
                       "treats them as tagged integers");
  return (void *)(v ^ 1);
}

#define Value_val(v) ((LLVMValueRef)from_val(v))
#define Module_val(v) ((LLVMModuleRef)from_val(v))
#define Type_val(v) ((LLVMTypeRef)from_val(v))

extern "C"
{
  /* bool -> llvalue -> unit */
  value llvm_set_nuw(value flag, value instr)
  {
    CAMLparam2(flag, instr);
    LLVMValueRef value_ref = Value_val(instr);
    Value *v = unwrap<Value>(value_ref);
    cast<Instruction>(v)->setHasNoUnsignedWrap(Bool_val(flag));
    CAMLreturn(Val_unit);
  }

  /* bool -> llvalue -> unit */
  value llvm_set_nsw(value flag, value instr)
  {
    CAMLparam2(flag, instr);
    LLVMValueRef value_ref = Value_val(instr);
    Value *v = unwrap<Value>(value_ref);
    cast<Instruction>(v)->setHasNoSignedWrap(Bool_val(flag));
    CAMLreturn(Val_unit);
  }

  /* bool -> llvalue -> unit */
  value llvm_set_exact(value flag, value instr)
  {
    CAMLparam2(flag, instr);
    LLVMValueRef value_ref = Value_val(instr);
    Value *v = unwrap<Value>(value_ref);
    cast<Instruction>(v)->setIsExact(Bool_val(flag));
    CAMLreturn(Val_unit);
  }

  /* llvalue -> bool */
  value llvm_is_nuw(value instr)
  {
    CAMLparam1(instr);
    LLVMValueRef value_ref = Value_val(instr);
    Value *v = unwrap<Value>(value_ref);
    bool ret = cast<Instruction>(v)->hasNoUnsignedWrap();
    CAMLreturn(Val_bool(ret));
  }

  /* llvalue -> bool */
  value llvm_is_nsw(value instr)
  {
    CAMLparam1(instr);
    LLVMValueRef value_ref = Value_val(instr);
    Value *v = unwrap<Value>(value_ref);
    bool ret = cast<Instruction>(v)->hasNoSignedWrap();
    CAMLreturn(Val_bool(ret));
  }

  /* llvalue -> bool */
  value llvm_is_exact(value instr)
  {
    CAMLparam1(instr);
    LLVMValueRef value_ref = Value_val(instr);
    Value *v = unwrap<Value>(value_ref);
    bool ret = cast<Instruction>(v)->isExact();
    CAMLreturn(Val_bool(ret));
  }

  value llvm_set_opaque_pointers(value Ctx, value Enable)
  {
    CAMLparam2(Ctx, Enable);
    LLVMContextRef Ct = (LLVMContextRef)from_val(Ctx);
    LLVMContext *C = unwrap(Ct);
    C->setOpaquePointers(Bool_val(Enable));
    CAMLreturn(Val_unit);
  }

  value llvm_get_alloca_type(value v)
  {
    CAMLparam1(v);
    LLVMValueRef instr = Value_val(v);
    if (const auto *foo = dyn_cast<AllocaInst>(unwrap(instr)))
    {
      CAMLreturn(to_val(foo->getAllocatedType()));
    }
    else if (const auto *CE = unwrap<ConstantExpr>(instr))
    {
      AllocaInst *foo = (AllocaInst *)CE->getAsInstruction();
      CAMLreturn(to_val(foo->getAllocatedType()));
    }
    assert(false);
  }

  value wrap_llvm_verify_module(value M)
  {
    CAMLparam1(M);
    try {
      char *Message;
      int Result =
          LLVMVerifyModule(Module_val(M), LLVMReturnStatusAction, &Message);

      CAMLreturn(Val_bool(0 == Result));
    } catch (std::exception &e) {
      CAMLreturn(Val_bool(false));
    }
  }

  value llvm_clean_module_data(value M) {
    CAMLparam1(M);
    Module *Mod = unwrap(Module_val(M));

    if (!Mod->getModuleIdentifier().empty())
      Mod->setModuleIdentifier("");

    if (!Mod->getSourceFileName().empty())
      Mod->setSourceFileName("");

    if (!Mod->getDataLayoutStr().empty())
      Mod->setDataLayout("");

    if (!Mod->getTargetTriple().empty())
      Mod->setTargetTriple("");

    if (!Mod->getModuleInlineAsm().empty())
      Mod->setModuleInlineAsm("");

    CAMLreturn(Val_unit);
  }

  // Reference:
  // https://github.com/llvm/llvm-project/blob/fe20a759fcd20e1755ea1b34c5e6447a787925dc/llvm/lib/Transforms/Utils/CloneFunction.cpp#L320
  value llvm_transforms_utils_clone_function(value F, value RetTy) {
    CAMLparam2(F, RetTy);
    Function *OldFunc = unwrap<Function>(Value_val(F));
    Type *RT = unwrap<Type>(Type_val(RetTy));

    std::vector<Type *> ArgTypes = OldFunc->getFunctionType()->params();
    bool IsVarArg = OldFunc->getFunctionType()->isVarArg();
    FunctionType *NewFTy = FunctionType::get(RT, ArgTypes, IsVarArg);

    Module *M = OldFunc->getParent();
    Function *NewFunc =
        Function::Create(NewFTy, OldFunc->getLinkage(), OldFunc->getName(), M);

    ValueToValueMapTy VMap;
    Function::arg_iterator DestI = NewFunc->arg_begin();
    for (const Argument &I : OldFunc->args()) {
      DestI->setName(I.getName());
      VMap[&I] = &*DestI++;
    }

    SmallVector<ReturnInst *, 8> Returns;
    CloneFunctionInto(NewFunc, OldFunc, VMap,
                      CloneFunctionChangeType::LocalChangesOnly, Returns, "",
                      nullptr);
    CAMLreturn(to_val(NewFunc));
  }

  value llvm_bb_transfer_instructions(value ToBB, value FromBB) {
    CAMLparam2(ToBB, FromBB);
    BasicBlock *Dest = unwrap<BasicBlock>(Value_val(ToBB));
    BasicBlock *Src = unwrap<BasicBlock>(Value_val(FromBB));

    Dest->splice(Dest->end(), Src);

    CAMLreturn(Val_unit);
  }
}
