target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_write_find_filter(ptr %rp, i8 %0) {
entry:
  %conv13 = zext i8 %0 to i32
  store i32 %conv13, ptr %rp, align 4
  %1 = load i32, ptr %rp, align 4
  %cmp14 = icmp ult i32 %1, 128
  br i1 %cmp14, label %cond.true, label %common.ret

common.ret:                                       ; preds = %cond.true, %entry
  ret void

cond.true:                                        ; preds = %entry
  %2 = load i32, ptr %rp, align 4
  br label %common.ret
}
