#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include "llvm_ext_ocaml.h"

#include "llvm-c/Analysis.h"
#include "llvm-c/Core.h"
#include "llvm-c/DebugInfo.h"
#include "llvm-c/Support.h"

#include "llvm/Config/llvm-config.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/ModuleSlotTracker.h"
#include "llvm/IR/ReplaceConstant.h"
#include "llvm/IR/Verifier.h"

#include "caml/alloc.h"
#include "caml/mlvalues.h"
#include "caml/memory.h"
#include "caml/fail.h"
#include "caml/callback.h"
// #include "llvm_ocaml.h"

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

#define Module_val(v) ((LLVMModuleRef)from_val(v))

extern "C"
{
  /* bool -> llvalue -> unit */
  value llvm_set_nuw(value flag, LLVMValueRef instr)
  {
    auto foo = dyn_cast<Instruction>(unwrap(instr));
    foo->setHasNoUnsignedWrap(Bool_val(flag));
    return Val_unit;
  }

  /* bool -> llvalue -> unit */
  value llvm_set_nsw(value flag, LLVMValueRef instr)
  {
    auto foo = dyn_cast<Instruction>(unwrap(instr));
    foo->setHasNoSignedWrap(Bool_val(flag));
    return Val_unit;
  }

  /* bool -> llvalue -> unit */
  value llvm_set_exact(value flag, LLVMValueRef instr)
  {
    auto foo = dyn_cast<Instruction>(unwrap(instr));
    foo->setIsExact(Bool_val(flag));
    return Val_unit;
  }

  /* llvalue -> bool */
  value llvm_is_nuw(LLVMValueRef instr)
  {
    auto foo = dyn_cast<Instruction>(unwrap(instr));
    return foo->hasNoUnsignedWrap();
  }

  /* llvalue -> bool */
  value llvm_is_nsw(LLVMValueRef instr)
  {
    auto foo = dyn_cast<Instruction>(unwrap(instr));
    return foo->hasNoSignedWrap();
  }

  /* llvalue -> bool */
  value llvm_is_exact(LLVMValueRef instr)
  {
    auto foo = dyn_cast<Instruction>(unwrap(instr));
    return foo->isExact();
  }

  value llvm_set_opaque_pointers(value Ctx, value Enable)
  {
    LLVMContextRef Ct = (LLVMContextRef)from_val(Ctx);
    LLVMContext *C = unwrap(Ct);
    C->setOpaquePointers(Bool_val(Enable));
    return Val_unit;
  }

  value llvm_get_alloca_type(value v)
  {
    LLVMValueRef instr = (LLVMValueRef)from_val(v);
    if (const auto *foo = dyn_cast<AllocaInst>(unwrap(instr)))
    {
      return to_val(foo->getAllocatedType());
    }
    else if (const auto *CE = unwrap<ConstantExpr>(instr))
    {
      AllocaInst *foo = (AllocaInst *)CE->getAsInstruction();
      return to_val(foo->getAllocatedType());
    }
    assert(false);
  }

  value wrap_llvm_verify_module(value M)
  {
    try
    {
      char *Message;
      int Result =
          LLVMVerifyModule(Module_val(M), LLVMReturnStatusAction, &Message);

      if (0 == Result)
      {
        return Val_bool(true);
      }
      else
      {
        return Val_bool(false);
      }
    }
    catch (std::exception &e)
    {
      return Val_bool(false);
    }
  }
}