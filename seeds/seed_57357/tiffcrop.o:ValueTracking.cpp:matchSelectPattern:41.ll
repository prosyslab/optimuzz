target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call1471 = call i32 @loadImage(i1 false, i1 false)
  ret i32 0
}

define internal i32 @loadImage(i1 %cmp66, i1 %cmp69) {
entry:
  %or.cond = select i1 %cmp66, i1 false, i1 %cmp69
  call void @llvm.assume(i1 %or.cond)
  ret i32 0
}

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }
