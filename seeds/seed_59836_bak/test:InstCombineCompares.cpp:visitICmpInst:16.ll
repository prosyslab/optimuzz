target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, ptr, ptr }

define ptr @xvasprintf() {
entry:
  %call1 = call ptr @xstrcat(i64 0, ptr null)
  ret ptr null
}

define internal ptr @xstrcat(i64 %0, ptr %ap) {
entry:
  %cmp = icmp ugt i64 %0, 0
  br i1 %cmp, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret ptr null

for.body:                                         ; preds = %entry
  %arraydecay1 = getelementptr [1 x %struct.__va_list_tag], ptr %ap, i64 0, i64 0
  br label %common.ret
}
