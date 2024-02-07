target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_write_start_row(ptr %filters, i8 %0, i1 %cmp27) {
entry:
  %spec.store.select = select i1 %cmp27, i8 0, i8 %0
  %conv32 = zext i8 %spec.store.select to i32
  %cmp34 = icmp ne i32 %conv32, 0
  br i1 %cmp34, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret void

land.lhs.true:                                    ; preds = %entry
  %1 = load ptr, ptr %filters, align 8
  br label %common.ret
}
