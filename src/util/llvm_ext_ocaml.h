#ifndef LLVM_EXT_OCAML_H
#define LLVM_EXT_OCAML_H

#include "caml/alloc.h"
#include "caml/custom.h"
#include "caml/version.h"

#include "llvm/IR/Instructions.h"

using namespace llvm;

extern "C"
{
#define Val_none Val_int(0)

    // https://github.com/llvm/llvm-project/blob/main/llvm/bindings/ocaml/llvm/llvm_ocaml.c
    extern value cstr_to_string(const char *Str, mlsize_t Len);
    extern value ptr_to_option(void *Ptr);
    
    void LLVMConvertConstantExprsInst(Instruction *I);
}
#endif
