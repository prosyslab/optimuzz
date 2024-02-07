target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @arp_check(ptr %cnt, i32 %0) {
entry:
  %dec = add nsw i32 %0, 1
  %cmp143 = icmp sle i32 %dec, 0
  br i1 %cmp143, label %if.then145, label %common.ret

common.ret:                                       ; preds = %if.then145, %entry
  ret i32 0

if.then145:                                       ; preds = %entry
  %1 = load i32, ptr %cnt, align 4
  br label %common.ret
}
