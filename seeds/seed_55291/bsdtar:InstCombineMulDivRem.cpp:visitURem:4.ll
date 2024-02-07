target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @ar_parse_common_header(ptr %n, i64 %0) {
entry:
  %n1 = alloca i64, align 8
  %1 = load i64, ptr %n, align 8
  %rem = urem i64 %0, 2
  store i64 %rem, ptr undef, align 8
  ret i32 0
}
