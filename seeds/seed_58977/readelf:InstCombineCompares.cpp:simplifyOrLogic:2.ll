target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sha1_process_block(i32 %0) {
entry:
  %and888 = and i32 %0, 1
  %or889 = or i32 1, %and888
  %add891 = or i32 %or889, 0
  ret void
}
