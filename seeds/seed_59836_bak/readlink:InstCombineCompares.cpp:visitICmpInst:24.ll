target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @canonicalize_filename_mode() {
entry:
  %call11 = call ptr @canonicalize_filename_mode_stk(i64 0)
  ret ptr null
}

define internal ptr @canonicalize_filename_mode_stk(i64 %0) {
entry:
  %add204 = add i64 %0, 1
  %cmp205 = icmp ule i64 %0, %add204
  call void @llvm.assume(i1 %cmp205)
  ret ptr null
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
