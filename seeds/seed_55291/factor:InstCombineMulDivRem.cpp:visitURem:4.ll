target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal void @mp_factor_using_pollard_rho(ptr %k, i64 %0) {
entry:
  %k1 = alloca i64, align 8
  br label %do.body

do.body:                                          ; preds = %entry
  br label %if.end

if.end:                                           ; preds = %do.body
  br label %do.end

do.end:                                           ; preds = %if.end
  br label %while.cond

while.cond:                                       ; preds = %do.end
  br label %while.body

while.body:                                       ; preds = %while.cond
  br label %for.cond

for.cond:                                         ; preds = %while.body
  br label %do.body7

do.body7:                                         ; preds = %for.cond
  %1 = load i64, ptr %k, align 8
  %rem = urem i64 %0, 32
  %cmp23 = icmp eq i64 %rem, 0
  br i1 %cmp23, label %if.then24, label %if.end34

if.then24:                                        ; preds = %do.body7
  ret void

if.end34:                                         ; preds = %do.body7
  ret void
}
