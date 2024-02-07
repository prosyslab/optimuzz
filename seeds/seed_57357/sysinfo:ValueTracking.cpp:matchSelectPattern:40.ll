target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @yy_flush_buffer(ptr %yy_buffer_stack) {
entry:
  %tobool5 = icmp ne ptr %yy_buffer_stack, null
  br i1 %tobool5, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %0 = load ptr, ptr %yy_buffer_stack, align 8
  br label %cond.false

cond.false:                                       ; preds = %cond.true, %entry
  ret void
}
