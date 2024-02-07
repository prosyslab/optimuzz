target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @bfd_hash_lookup(ptr %len, i32 %0) {
entry:
  %add = add i32 %0, 1
  %conv16 = zext i32 %add to i64
  store i64 %conv16, ptr %len, align 8
  %cmp17 = icmp eq i32 %add, 0
  %spec.store.select = zext i1 %cmp17 to i64
  store i64 %spec.store.select, ptr %len, align 8
  ret ptr null
}
