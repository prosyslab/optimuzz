target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ParseAiffHeaderConfig(ptr %config.addr, i32 %0) {
entry:
  %rem = srem i32 %0, 8
  %tobool309 = icmp ne i32 %rem, 0
  br i1 %tobool309, label %if.then310, label %if.end316

if.then310:                                       ; preds = %entry
  %1 = load ptr, ptr %config.addr, align 8
  br label %if.end316

if.end316:                                        ; preds = %if.then310, %entry
  ret i32 0
}
