#include "llvm_ext_ocaml.h"

#include "llvm-c/Core.h"
#include "llvm/IR/Instruction.h"

using namespace llvm;

void *from_val(value v) { return (void *)(v ^ 1); }

extern "C" {
/* bool -> llvalue -> unit */
value llvm_set_nuw(value flag, LLVMValueRef instr) {
  auto foo = dyn_cast<Instruction>(unwrap(instr));
  foo->setHasNoUnsignedWrap(Bool_val(flag));
  return Val_unit;
}

/* bool -> llvalue -> unit */
value llvm_set_nsw(value flag, LLVMValueRef instr) {
  auto foo = dyn_cast<Instruction>(unwrap(instr));
  foo->setHasNoSignedWrap(Bool_val(flag));
  return Val_unit;
}

/* bool -> llvalue -> unit */
value llvm_set_exact(value flag, LLVMValueRef instr) {
  auto foo = dyn_cast<Instruction>(unwrap(instr));
  foo->setIsExact(Bool_val(flag));
  return Val_unit;
}

/* llvalue -> bool */
value llvm_is_nuw(LLVMValueRef instr) {
  auto foo = dyn_cast<Instruction>(unwrap(instr));
  return foo->hasNoUnsignedWrap();
}

/* llvalue -> bool */
value llvm_is_nsw(LLVMValueRef instr) {
  auto foo = dyn_cast<Instruction>(unwrap(instr));
  return foo->hasNoSignedWrap();
}

/* llvalue -> bool */
value llvm_is_exact(LLVMValueRef instr) {
  auto foo = dyn_cast<Instruction>(unwrap(instr));
  return foo->isExact();
}
}