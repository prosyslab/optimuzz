target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @char_unicode_to_cp437(ptr %c.addr, i32 %0) {
entry:
  %cmp = icmp uge i32 %0, 1
  br i1 %cmp, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret i32 0

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, ptr %c.addr, align 4
  br label %common.ret
}
