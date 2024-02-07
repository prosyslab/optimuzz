target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @mb_copy(ptr %old_mbc.addr, i8 %0) {
entry:
  %tobool = trunc i8 %0 to i1
  %frombool = zext i1 %tobool to i8
  store i8 %frombool, ptr %old_mbc.addr, align 8
  ret void
}
