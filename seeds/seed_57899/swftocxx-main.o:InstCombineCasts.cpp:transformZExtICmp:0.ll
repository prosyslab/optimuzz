target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
if.end21:
  %call221 = call i32 @readMovieHeader(ptr null, i8 0)
  ret i32 0
}

define internal i32 @readMovieHeader(ptr %first, i8 %0) {
entry:
  %cmp = icmp eq i8 %0, 0
  %cond = zext i1 %cmp to i32
  store i32 %cond, ptr %first, align 4
  ret i32 0
}
