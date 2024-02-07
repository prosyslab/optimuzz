target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @dmoz_path_is_absolute(i1 %cmp7) {
entry:
  %cond = select i1 %cmp7, i32 2, i32 0
  ret i32 %cond
}
