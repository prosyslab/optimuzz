target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @cycle_check() {
entry:
  %call11 = call i1 @is_zero_or_power_of_two(i64 0)
  ret i1 false
}

define internal i1 @is_zero_or_power_of_two(i64 %0) {
entry:
  %sub = sub i64 %0, 1
  %and = and i64 %0, %sub
  %cmp = icmp eq i64 %and, 0
  ret i1 %cmp
}
