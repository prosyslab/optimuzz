target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @ssl_check_certificate(ptr %pinsuccess, i32 %0, i1 %tobool106) {
entry:
  %cond109 = select i1 %tobool106, i32 %0, i32 0
  %tobool112 = icmp ne i32 %cond109, 0
  store i1 %tobool112, ptr %pinsuccess, align 1
  ret i1 false
}
