target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @SWFBlockList_addBlock(i8 %call, ptr %list.addr) {
entry:
  %tobool = icmp ne i8 %call, 0
  br i1 %tobool, label %common.ret, label %if.end

common.ret:                                       ; preds = %if.end, %entry
  ret void

if.end:                                           ; preds = %entry
  %0 = load ptr, ptr %list.addr, align 8
  br label %common.ret
}
