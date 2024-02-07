target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sha256_process_block(ptr %a, i32 %0) {
entry:
  %and41 = and i32 1, %0
  %or42 = or i32 1, %and41
  store i32 %or42, ptr %a, align 4
  ret void
}
