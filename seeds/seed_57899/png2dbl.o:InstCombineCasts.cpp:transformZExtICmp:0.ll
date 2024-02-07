target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @writeDBL(i32 %0) {
entry:
  %tobool.not = icmp ne i32 %0, 0
  %cond = zext i1 %tobool.not to i32
  %call5 = call i32 @fputc(i32 %cond)
  ret void
}

declare i32 @fputc(i32)
