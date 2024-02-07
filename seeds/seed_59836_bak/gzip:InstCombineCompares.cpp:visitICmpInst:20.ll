target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @flush_block(ptr %compressed_len, i64 %0) {
entry:
  %rem = srem i64 %0, 8
  %cmp59 = icmp ne i64 %rem, 0
  br i1 %cmp59, label %if.then61, label %if.end66

if.then61:                                        ; preds = %entry
  %1 = load i32, ptr %compressed_len, align 4
  br label %if.end66

if.end66:                                         ; preds = %if.then61, %entry
  ret i64 0
}
