target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @program_name(ptr %tmp, ptr %0) {
entry:
  %tobool.not = icmp eq ptr %0, null
  %cond = select i1 %tobool.not, ptr %tmp, ptr null
  store ptr %cond, ptr %tmp, align 8
  ret ptr null
}
