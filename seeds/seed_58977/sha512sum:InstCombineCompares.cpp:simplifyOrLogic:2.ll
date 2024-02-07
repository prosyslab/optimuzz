target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sha512_process_block(ptr %a, i64 %0) {
entry:
  %and43 = and i64 1, %0
  %or44 = or i64 1, %and43
  store i64 %or44, ptr %a, align 8
  ret void
}
