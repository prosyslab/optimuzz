target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb6

sw.bb6:                                           ; preds = %sw.bb6, %entry
  br label %sw.bb6

cond.true:                                        ; No predecessors!
  call void @expand(ptr null, i64 0)
  ret i32 0
}

define internal void @expand(ptr %column, i64 %0) {
entry:
  %inc38 = add i64 %0, 1
  store i64 %inc38, ptr %column, align 8
  %tobool39.not = icmp eq i64 %inc38, 0
  call void @llvm.assume(i1 %tobool39.not)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
