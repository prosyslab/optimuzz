target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i64 @quotearg_buffer_restyled(ptr %quote_these_too.addr, i8 %0) {
entry:
  %conv571 = zext i8 %0 to i64
  %rem = urem i64 %conv571, 32
  %sh_prom = trunc i64 %rem to i32
  %tobool574 = icmp ne i32 %sh_prom, 0
  br i1 %tobool574, label %if.end578, label %land.lhs.true575

land.lhs.true575:                                 ; preds = %entry
  %1 = load i8, ptr %quote_these_too.addr, align 1
  br label %if.end578

if.end578:                                        ; preds = %land.lhs.true575, %entry
  ret i64 0
}

define ptr @quotearg_alloc_mem() {
entry:
  %call41 = call i64 @quotearg_buffer_restyled(ptr null, i8 0)
  ret ptr null
}
