target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @get_fs_usage(ptr %fsp.addr, i64 %0) {
entry:
  %and = and i64 %0, 1
  %or = or i64 1, %and
  store i64 %or, ptr %fsp.addr, align 8
  ret i32 0
}
