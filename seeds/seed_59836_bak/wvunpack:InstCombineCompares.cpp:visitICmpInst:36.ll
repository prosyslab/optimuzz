target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @WriteCaffHeader(ptr %new_channel_order) {
entry:
  %tobool164 = icmp ne ptr %new_channel_order, null
  br i1 %tobool164, label %cond.true165, label %common.ret

common.ret:                                       ; preds = %cond.true165, %entry
  ret i32 0

cond.true165:                                     ; preds = %entry
  %0 = load ptr, ptr %new_channel_order, align 8
  br label %common.ret
}
