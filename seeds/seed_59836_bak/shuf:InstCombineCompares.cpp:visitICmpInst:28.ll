target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @isaac_refill(ptr %m, ptr %0) {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %add.ptr83 = getelementptr i64, ptr %0, i64 4
  %cmp = icmp ult ptr %add.ptr83, %m
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret void
}
