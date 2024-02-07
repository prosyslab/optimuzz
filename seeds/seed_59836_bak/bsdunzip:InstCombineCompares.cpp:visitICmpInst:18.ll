target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @archive_string_append_from_wcs(ptr %w.addr, i32 %0, i1 %cmp9) {
entry:
  %cmp8 = icmp ne i32 %0, 0
  %1 = select i1 %cmp8, i1 %cmp9, i1 false
  br i1 %1, label %while.body, label %common.ret

common.ret:                                       ; preds = %while.body, %entry
  ret i32 0

while.body:                                       ; preds = %entry
  %2 = load ptr, ptr %w.addr, align 8
  br label %common.ret
}
