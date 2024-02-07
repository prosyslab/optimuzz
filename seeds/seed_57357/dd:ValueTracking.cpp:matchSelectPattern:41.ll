target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i64 @quotearg_buffer_restyled(ptr %backslash_escapes, i1 %tobool53, i1 %cmp55) {
entry:
  %or.cond = select i1 %tobool53, i1 %cmp55, i1 false
  br i1 %or.cond, label %land.lhs.true57, label %if.end80

land.lhs.true57:                                  ; preds = %entry
  %0 = load i64, ptr %backslash_escapes, align 8
  br label %if.end80

if.end80:                                         ; preds = %land.lhs.true57, %entry
  ret i64 0
}

define internal ptr @quotearg_n_options() {
entry:
  %call211 = call i64 @quotearg_buffer_restyled(ptr null, i1 false, i1 false)
  ret ptr null
}

define ptr @quotearg_n_style() {
entry:
  %call = call ptr @quotearg_n_options()
  ret ptr null
}
