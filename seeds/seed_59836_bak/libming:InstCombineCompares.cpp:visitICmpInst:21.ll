target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @SWFBlockList_addBlock(i32 %call15, ptr %0) {
entry:
  %cmp16 = icmp ne i32 %call15, 0
  %conv18 = zext i1 %cmp16 to i8
  store i8 %conv18, ptr %0, align 8
  ret void
}
