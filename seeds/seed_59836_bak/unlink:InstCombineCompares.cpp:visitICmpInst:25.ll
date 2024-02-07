target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i64 @quotearg_buffer_restyled(ptr %quote_these_too.addr, i32 %0) {
entry:
  %shr572 = lshr i32 %0, 1
  %tobool574 = icmp ne i32 %shr572, 0
  br i1 %tobool574, label %if.end578, label %land.lhs.true575

land.lhs.true575:                                 ; preds = %entry
  %1 = load i8, ptr %quote_these_too.addr, align 1
  br label %if.end578

if.end578:                                        ; preds = %land.lhs.true575, %entry
  ret i64 0
}

define internal ptr @quotearg_n_options() {
entry:
  %call211 = call i64 @quotearg_buffer_restyled(ptr null, i32 0)
  ret ptr null
}

define ptr @quotearg_n_custom_mem() {
entry:
  %call = call ptr @quotearg_n_options()
  ret ptr null
}
