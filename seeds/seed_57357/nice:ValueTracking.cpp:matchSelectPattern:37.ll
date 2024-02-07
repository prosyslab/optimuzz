target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @xstrtol(i32 %0, i1 %cmp1) {
entry:
  %cmp = icmp sgt i32 %0, 0
  %or.cond = select i1 %cmp, i1 %cmp1, i1 false
  call void @llvm.assume(i1 %or.cond)
  ret i32 0
}

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }
