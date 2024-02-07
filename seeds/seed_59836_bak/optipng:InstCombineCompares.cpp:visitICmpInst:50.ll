target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_write_finish_row(ptr %png_ptr.addr, i8 %0) {
entry:
  %conv68 = zext i8 %0 to i32
  %conv69 = zext i8 %0 to i32
  %mul = mul i32 %conv68, %conv69
  %cmp70 = icmp sge i32 %mul, 1
  br i1 %cmp70, label %cond.true, label %common.ret

common.ret:                                       ; preds = %cond.true, %entry
  ret void

cond.true:                                        ; preds = %entry
  %1 = load ptr, ptr %png_ptr.addr, align 8
  br label %common.ret
}
