target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i64 @quotearg_buffer_restyled(ptr %printable, i8 %0) {
entry:
  %tobool416 = trunc i8 %0 to i1
  %frombool417 = zext i1 %tobool416 to i8
  store i8 %frombool417, ptr %printable, align 1
  ret i64 0
}

define ptr @quotearg_alloc_mem() {
cond.end:
  %call41 = call i64 @quotearg_buffer_restyled(ptr null, i8 0)
  ret ptr null
}
