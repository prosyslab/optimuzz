target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @connect_to_ip(ptr %sock, i32 %0) {
entry:
  %cmp98 = icmp sge i32 %0, 0
  br i1 %cmp98, label %if.then100, label %if.end101

if.then100:                                       ; preds = %entry
  %1 = load i32, ptr %sock, align 4
  br label %if.end101

if.end101:                                        ; preds = %if.then100, %entry
  ret i32 0
}
