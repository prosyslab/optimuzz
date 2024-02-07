target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @archive_string_append_from_wcs(ptr %len.addr, i64 %0) {
entry:
  %cmp9 = icmp ugt i64 %0, 0
  br i1 %cmp9, label %while.body, label %common.ret

common.ret:                                       ; preds = %while.body, %entry
  ret i32 0

while.body:                                       ; preds = %entry
  %1 = load ptr, ptr %len.addr, align 8
  br label %common.ret
}
