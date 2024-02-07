target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @lookup_host(ptr %0, i8 %1) {
entry:
  %tobool4 = trunc i8 %1 to i1
  %frombool5 = zext i1 %tobool4 to i8
  store i8 %frombool5, ptr %0, align 1
  ret ptr null
}
