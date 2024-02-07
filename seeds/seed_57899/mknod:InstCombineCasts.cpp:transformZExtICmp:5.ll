target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @rpl_fts_open(ptr %sp, i32 %0) {
entry:
  %and49 = and i32 %0, 1024
  %cmp50 = icmp ne i32 %and49, 0
  %frombool = zext i1 %cmp50 to i8
  store i8 %frombool, ptr %sp, align 1
  ret ptr null
}
