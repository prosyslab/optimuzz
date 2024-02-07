target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @can_write_any_file(ptr %can, i8 %0) {
entry:
  %tobool1 = trunc i8 %0 to i1
  %frombool2 = zext i1 %tobool1 to i8
  store i8 %frombool2, ptr %can, align 1
  ret i1 false
}
