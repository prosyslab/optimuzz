target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @mktime_internal(ptr %isdst, i1 %cmp41, i1 %cmp44) {
entry:
  %conv42 = zext i1 %cmp41 to i32
  %conv45 = zext i1 %cmp44 to i32
  %cmp46 = icmp ne i32 %conv42, %conv45
  br i1 %cmp46, label %common.ret, label %if.end49

common.ret:                                       ; preds = %if.end49, %entry
  ret i64 0

if.end49:                                         ; preds = %entry
  %0 = load i32, ptr %isdst, align 4
  br label %common.ret
}
