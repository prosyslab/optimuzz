target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @dmoz_path_is_absolute(ptr %path.addr, i8 %0) {
entry:
  %conv10 = sext i8 %0 to i32
  %cmp11 = icmp eq i32 %conv10, 0
  %cond = select i1 %cmp11, i32 1, i32 0
  store i32 %cond, ptr %path.addr, align 4
  ret i32 0
}
