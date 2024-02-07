target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.then29:                                        ; No predecessors!
  call void @unexpand(ptr null, i64 0)
  ret i32 0
}

define internal void @unexpand(ptr %column, i64 %0) {
entry:
  %inc66 = add i64 %0, 1
  store i64 %inc66, ptr %column, align 8
  %tobool67.not = icmp eq i64 %inc66, 0
  call void @llvm.assume(i1 %tobool67.not)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
