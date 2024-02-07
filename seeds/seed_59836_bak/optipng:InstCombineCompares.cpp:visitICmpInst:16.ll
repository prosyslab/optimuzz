target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_calculate_crc(ptr %length.addr, i64 %0) {
entry:
  %cmp11 = icmp ugt i64 %0, 0
  br i1 %cmp11, label %if.then12, label %common.ret

common.ret:                                       ; preds = %if.then12, %entry
  ret void

if.then12:                                        ; preds = %entry
  %1 = load ptr, ptr %length.addr, align 8
  br label %common.ret
}
