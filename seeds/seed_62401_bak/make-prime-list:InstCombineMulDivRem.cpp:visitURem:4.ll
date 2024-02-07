target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %return

if.then6:                                         ; No predecessors!
  call void @output_primes()
  br label %return

return:                                           ; preds = %if.then6, %entry
  ret i32 0
}

define internal void @output_primes() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.end:                                           ; No predecessors!
  call void @print_wide_uint(ptr null, i32 0)
  unreachable
}

define internal void @print_wide_uint(ptr %bits_per_literal, i32 %0) {
entry:
  %rem21 = urem i32 %0, 4
  store i32 %rem21, ptr %bits_per_literal, align 4
  ret void
}
