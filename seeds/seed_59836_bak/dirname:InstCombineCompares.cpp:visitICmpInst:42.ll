target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @c_strcasecmp(i8 %0) {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %conv5 = zext i8 %0 to i32
  %cmp6 = icmp eq i32 %conv5, 0
  br i1 %cmp6, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  ret i32 0
}
