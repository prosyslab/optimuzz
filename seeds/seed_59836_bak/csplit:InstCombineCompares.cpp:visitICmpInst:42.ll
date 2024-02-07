target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i64 @quotearg_buffer_restyled(ptr %arg.addr, i8 %0) {
entry:
  %conv = sext i8 %0 to i32
  %cmp47 = icmp eq i32 %conv, 0
  br i1 %cmp47, label %for.body52, label %common.ret

common.ret:                                       ; preds = %for.body52, %entry
  ret i64 0

for.body52:                                       ; preds = %entry
  store i8 0, ptr %arg.addr, align 1
  br label %common.ret
}

define internal ptr @quotearg_n_options() {
entry:
  %call211 = call i64 @quotearg_buffer_restyled(ptr null, i8 0)
  ret ptr null
}

define ptr @quotearg_n_style() {
entry:
  %call = call ptr @quotearg_n_options()
  ret ptr null
}
