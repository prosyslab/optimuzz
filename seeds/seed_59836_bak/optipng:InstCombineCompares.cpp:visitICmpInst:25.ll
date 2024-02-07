target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_calculate_crc(ptr %png_ptr.addr, i32 %0) {
entry:
  %shr = lshr i32 %0, 1
  %cmp = icmp ne i32 %shr, 0
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret void

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %png_ptr.addr, align 8
  br label %common.ret
}
