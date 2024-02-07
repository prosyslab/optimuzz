target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @SWFBlockList_addBlock(i8 %call9, ptr %block.addr) {
entry:
  %conv10 = zext i8 %call9 to i32
  %tobool11 = icmp ne i32 %conv10, 0
  br i1 %tobool11, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret void

land.lhs.true:                                    ; preds = %entry
  %0 = load ptr, ptr %block.addr, align 8
  br label %common.ret
}
