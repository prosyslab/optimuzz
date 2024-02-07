target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i64 @quotearg_buffer_restyled(ptr %quoting_style.addr, i32 %0, i1 %tobool58) {
entry:
  %cmp55 = icmp ne i32 %0, 0
  %or.cond = select i1 %cmp55, i1 %tobool58, i1 false
  br i1 %or.cond, label %land.lhs.true59, label %common.ret

common.ret:                                       ; preds = %land.lhs.true59, %entry
  ret i64 0

land.lhs.true59:                                  ; preds = %entry
  %1 = load i64, ptr %quoting_style.addr, align 8
  br label %common.ret
}

define internal ptr @quotearg_n_options() {
entry:
  %call211 = call i64 @quotearg_buffer_restyled(ptr null, i32 0, i1 false)
  ret ptr null
}

define ptr @quote_n_mem() {
entry:
  %call = call ptr @quotearg_n_options()
  ret ptr null
}
