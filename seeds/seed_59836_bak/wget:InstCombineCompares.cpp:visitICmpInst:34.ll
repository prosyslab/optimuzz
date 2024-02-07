target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @rpl_strtol(ptr %i, i1 %tobool134) {
entry:
  %0 = load i64, ptr %i, align 8
  %cond = select i1 %tobool134, i64 -9223372036854775808, i64 0
  %cmp135 = icmp ugt i64 %0, %cond
  br i1 %cmp135, label %if.then137, label %if.end138

if.then137:                                       ; preds = %entry
  store i32 0, ptr %i, align 4
  br label %if.end138

if.end138:                                        ; preds = %if.then137, %entry
  ret i64 0
}
