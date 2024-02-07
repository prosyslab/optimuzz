target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @hash_lookup(ptr %bucket) {
entry:
  %cmp = icmp eq ptr %bucket, null
  %0 = xor i1 %cmp, false
  call void @llvm.assume(i1 %cmp)
  ret ptr null
}

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }
