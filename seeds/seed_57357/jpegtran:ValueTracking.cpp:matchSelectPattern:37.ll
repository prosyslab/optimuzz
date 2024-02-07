target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @set_sample_factors(i32 %0) {
entry:
  %1 = icmp ult i32 %0, 1
  %or.cond50 = select i1 %1, i1 false, i1 true
  %or.cond51 = select i1 %or.cond50, i1 false, i1 false
  ret i32 0
}
