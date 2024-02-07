target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @connect_to_ip(ptr %0, i64 %1) {
entry:
  %conv55 = trunc i64 %1 to i32
  %cmp56 = icmp slt i32 %conv55, 512
  %spec.select = select i1 %cmp56, i32 512, i32 %conv55
  store i32 %spec.select, ptr %0, align 4
  ret i32 0
}
