target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal void @get_header(ptr %q1024, i64 %0) {
entry:
  %q10241 = alloca i64, align 8
  br label %for.cond

for.cond:                                         ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.cond
  br label %land.lhs.true

land.lhs.true:                                    ; preds = %for.body
  br label %if.then

if.then:                                          ; preds = %land.lhs.true
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.then
  %1 = load i64, ptr %q1024, align 8
  %rem8 = urem i64 %0, 1024
  %cmp9 = icmp eq i64 %rem8, 0
  %frombool10 = zext i1 %cmp9 to i8
  store i8 %frombool10, ptr undef, align 1
  br label %do.cond

do.cond:                                          ; preds = %do.body
  br i1 false, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  ret void
}
