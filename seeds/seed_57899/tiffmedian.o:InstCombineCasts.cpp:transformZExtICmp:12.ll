target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @quant_fsdither(ptr null, i32 0, i32 0)
  ret i32 0
}

define internal void @quant_fsdither(ptr %j, i32 %0, i32 %1) {
entry:
  %cmp60 = icmp eq i32 %0, %1
  %conv61 = zext i1 %cmp60 to i32
  store i32 %conv61, ptr %j, align 4
  ret void
}
