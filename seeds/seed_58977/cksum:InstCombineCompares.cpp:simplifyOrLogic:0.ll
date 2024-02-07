target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sm3_process_block(i32 %0) {
entry:
  %not = xor i32 %0, -1
  %or1215 = or i32 %0, %not
  %add1219 = or i32 0, %or1215
  ret void
}
