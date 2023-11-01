#ifndef LLVM_EXT_OCAML_H
#define LLVM_EXT_OCAML_H

#include "caml/mlvalues.h"

#include "llvm-c/Core.h"

extern void *from_val(value v);

#define Value_val(v) ((LLVMValueRef)from_val(v))
#define Builder_val(v) (*(LLVMBuilderRef *)(Data_custom_val(v)))

#endif
