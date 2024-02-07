target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @set_quant_slots(i32 %call, ptr %ch, i1 %cmp3.not) {
entry:
  %cmp1 = icmp sgt i32 %call, 0
  %or.cond = select i1 %cmp1, i1 %cmp3.not, i1 false
  br i1 %or.cond, label %if.end6, label %common.ret

common.ret:                                       ; preds = %if.end6, %entry
  ret i32 0

if.end6:                                          ; preds = %entry
  %0 = load i32, ptr %ch, align 4
  br label %common.ret
}
