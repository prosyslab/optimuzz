target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

define ptr @canonicalize_filename_mode() {
entry:
  %call1 = call ptr @canonicalize_filename_mode_stk(i64 0)
  ret ptr null
}

define internal ptr @canonicalize_filename_mode_stk(i64 %0) {
entry:
  %1 = xor i64 %0, -1
  %cmp205.not = icmp ult i64 %1, %0
  call void @llvm.assume(i1 %cmp205.not)
  ret ptr null
}

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
