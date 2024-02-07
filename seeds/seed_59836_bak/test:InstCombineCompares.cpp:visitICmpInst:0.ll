target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal ptr @quotearg_n_options(i32 %0) {
entry:
  %cmp = icmp sle i32 0, %0
  call void @llvm.assume(i1 %cmp)
  ret ptr null
}

define ptr @quote_n_mem() {
entry:
  %call1 = call ptr @quotearg_n_options(i32 0)
  ret ptr null
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
