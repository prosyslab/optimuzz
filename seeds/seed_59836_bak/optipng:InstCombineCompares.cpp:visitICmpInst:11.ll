target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @_tr_flush_bits() {
entry:
  call void @bi_flush(ptr null, i32 0)
  ret void
}

define internal void @bi_flush(ptr %s.addr, i32 %0) {
entry:
  %cmp12 = icmp sge i32 %0, 0
  br i1 %cmp12, label %if.then14, label %if.end

if.then14:                                        ; preds = %entry
  %1 = load ptr, ptr %s.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then14, %entry
  ret void
}
