target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @hash_lookup(ptr %cursor) {
entry:
  %tobool = icmp ne ptr %cursor, null
  br i1 %tobool, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret ptr null

for.body:                                         ; preds = %entry
  %0 = load ptr, ptr %cursor, align 8
  br label %common.ret
}
