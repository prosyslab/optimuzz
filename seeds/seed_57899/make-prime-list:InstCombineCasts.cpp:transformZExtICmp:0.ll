target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @output_primes()
  ret i32 0
}

define internal void @output_primes() {
entry:
  call void @print_wide_uint(ptr null, i64 0)
  ret void
}

define internal void @print_wide_uint(ptr %n.addr, i64 %0) {
entry:
  %cmp6 = icmp ne i64 %0, 0
  %conv7 = zext i1 %cmp6 to i32
  store i32 %conv7, ptr %n.addr, align 4
  ret void
}
