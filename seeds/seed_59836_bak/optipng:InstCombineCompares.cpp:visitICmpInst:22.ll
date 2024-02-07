target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_check_IHDR(ptr %width.addr, i32 %0) {
entry:
  %cmp1 = icmp ugt i32 %0, 2147483647
  br i1 %cmp1, label %if.then2, label %if.end3

if.then2:                                         ; preds = %entry
  %1 = load ptr, ptr %width.addr, align 8
  br label %if.end3

if.end3:                                          ; preds = %if.then2, %entry
  ret void
}
