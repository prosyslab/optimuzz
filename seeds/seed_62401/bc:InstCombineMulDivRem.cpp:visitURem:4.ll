target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @execute(ptr %label_num, i64 %0) {
entry:
  %rem = urem i64 %0, 64
  store i64 %rem, ptr %label_num, align 8
  ret void
}
