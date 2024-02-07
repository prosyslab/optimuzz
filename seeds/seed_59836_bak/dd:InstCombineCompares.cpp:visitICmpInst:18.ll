target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @human_readable(ptr %opts.addr, i32 %0) {
entry:
  %tobool.not = icmp eq i32 %0, 0
  %cond = select i1 %tobool.not, i64 1, i64 0
  store i64 %cond, ptr %opts.addr, align 8
  ret ptr null
}
