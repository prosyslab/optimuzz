target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @even(i64 %0) {
entry:
  %and = and i64 %0, 1
  %tobool = icmp ne i64 %and, 0
  %lnot.ext = zext i1 %tobool to i32
  ret i32 %lnot.ext
}
