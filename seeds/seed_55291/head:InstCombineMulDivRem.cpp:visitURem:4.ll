target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i1 @elide_tail_bytes_pipe(ptr %n_elide, i64 %0) {
entry:
  %n_elide1 = alloca i64, align 8
  br label %if.end

if.end:                                           ; preds = %entry
  br label %if.else51

if.else51:                                        ; preds = %if.end
  %1 = load i64, ptr %n_elide, align 8
  %rem56 = urem i64 %0, 8192
  %sub57 = sub i64 0, 8192
  store i64 %rem56, ptr undef, align 8
  br label %for.cond60

for.cond60:                                       ; preds = %if.else51
  br label %for.body64

for.body64:                                       ; preds = %for.cond60
  br label %if.then66

if.then66:                                        ; preds = %for.body64
  br label %if.then68

if.then68:                                        ; preds = %if.then66
  br i1 false, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.then68
  ret i1 false

cond.false:                                       ; preds = %if.then68
  ret i1 false
}
