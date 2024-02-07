target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sha1_process_block(i32 %0) {
entry:
  %and877 = and i32 %0, 1
  %or878 = or i32 1, %and877
  %add880 = or i32 %or878, 0
  ret void
}
