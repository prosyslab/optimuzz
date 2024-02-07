target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %coding_history459, i1 %cmp460.not) {
entry:
  %cmp464 = icmp eq ptr %coding_history459, null
  %or.cond = select i1 %cmp460.not, i1 %cmp464, i1 false
  call void @llvm.assume(i1 %or.cond)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
