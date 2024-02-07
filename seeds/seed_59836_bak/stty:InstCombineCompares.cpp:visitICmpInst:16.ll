target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @setlocale_null_r() {
entry:
  %call1 = call i32 @setlocale_null_unlocked(ptr null, i64 0)
  ret i32 0
}

define internal i32 @setlocale_null_unlocked(ptr %bufsize.addr, i64 %0) {
entry:
  %cmp1 = icmp ugt i64 %0, 0
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %entry
  %1 = load ptr, ptr %bufsize.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then2, %entry
  ret i32 0
}
