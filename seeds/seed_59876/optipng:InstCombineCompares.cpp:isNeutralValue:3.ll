target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal ptr @png_malloc_array_checked(ptr %req, i64 %0) {
entry:
  %div = udiv i64 -1, %0
  %cmp = icmp ule i64 %0, %div
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret ptr null

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %req, align 8
  br label %common.ret
}

define ptr @png_realloc_array() {
entry:
  unreachable

if.end:                                           ; No predecessors!
  %call1 = call ptr @png_malloc_array_checked(ptr null, i64 0)
  ret ptr null
}
