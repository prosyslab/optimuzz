target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @printf_parse(ptr %a_allocated, i64 %0) {
entry:
  %cmp210 = icmp ule i64 %0, 9223372036854775807
  %cond216 = select i1 %cmp210, i64 0, i64 1
  store i64 %cond216, ptr %a_allocated, align 8
  ret i32 0
}
