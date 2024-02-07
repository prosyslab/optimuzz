target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @count_leading_zeros_ll(i64 %0) {
entry:
  %tobool.not = icmp eq i64 %0, 0
  %conv1 = select i1 %tobool.not, i32 1, i32 0
  ret i32 %conv1
}
