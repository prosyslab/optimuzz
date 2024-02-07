target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @lafe_readpassphrase() {
entry:
  %call11 = call ptr @readpassphrase(i1 false, ptr null, i1 false)
  ret ptr null
}

define internal ptr @readpassphrase(i1 %cmp43, ptr %ch, i1 %cmp47) {
entry:
  %or.cond = select i1 %cmp47, i1 %cmp43, i1 false
  br i1 %or.cond, label %while.body, label %while.end

while.body:                                       ; preds = %entry
  %0 = load ptr, ptr %ch, align 8
  br label %while.end

while.end:                                        ; preds = %while.body, %entry
  ret ptr null
}
