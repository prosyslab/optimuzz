target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @scanargs()
  ret i32 0
}

define internal void @scanargs() {
entry:
  unreachable

if.then125:                                       ; No predecessors!
  %call19611 = call i1 @multiple_bits_set(i32 0)
  unreachable
}

define internal i1 @multiple_bits_set(i32 %0) {
entry:
  %sub = sub i32 %0, 1
  %and = and i32 %0, %sub
  %cmp = icmp ne i32 %and, 0
  ret i1 %cmp
}
