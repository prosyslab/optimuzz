target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @SWFDisplayItem_removeFromList(ptr %item.addr) {
entry:
  %cmp2 = icmp eq ptr %item.addr, null
  %or.cond = select i1 %cmp2, i1 false, i1 true
  br i1 %or.cond, label %common.ret, label %if.end

common.ret:                                       ; preds = %if.end, %entry
  ret void

if.end:                                           ; preds = %entry
  %0 = load ptr, ptr %item.addr, align 8
  br label %common.ret
}
