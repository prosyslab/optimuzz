target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @mapattr(ptr %tmp, i64 %0) {
entry:
  %and100 = and i64 %0, 1
  %tobool101 = icmp ne i64 %and100, 0
  %lnot = xor i1 %tobool101, true
  %lnot.ext = zext i1 %lnot to i32
  %conv103 = sext i32 %lnot.ext to i64
  store i64 %conv103, ptr %tmp, align 8
  ret i32 0
}
