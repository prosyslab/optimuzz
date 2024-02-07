target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  ret i32 0

if.end137:                                        ; No predecessors!
  %call1471 = call i32 @loadImage(i64 0)
  unreachable
}

define internal i32 @loadImage(i64 %conv166) {
entry:
  %cmp168 = icmp sgt i64 0, %conv166
  call void @llvm.assume(i1 %cmp168)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
