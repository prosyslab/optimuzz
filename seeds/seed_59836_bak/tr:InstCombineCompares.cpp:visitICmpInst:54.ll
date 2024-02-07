target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %delete, i8 %0, i1 %tobool14) {
entry:
  %conv = zext i1 %tobool14 to i32
  %tobool15 = trunc i8 %0 to i1
  %conv16 = zext i1 %tobool15 to i32
  %cmp17 = icmp eq i32 %conv, %conv16
  %conv18 = zext i1 %cmp17 to i32
  store i32 %conv18, ptr %delete, align 4
  ret i32 0
}
