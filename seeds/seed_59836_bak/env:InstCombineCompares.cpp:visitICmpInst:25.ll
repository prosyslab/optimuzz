target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @sig2str(ptr %signum.addr, i32 %0) {
entry:
  %sub20 = sub i32 %0, 1
  %cmp21 = icmp ne i32 %sub20, 0
  br i1 %cmp21, label %if.then23, label %if.end25

if.then23:                                        ; preds = %entry
  %1 = load ptr, ptr %signum.addr, align 8
  br label %if.end25

if.end25:                                         ; preds = %if.then23, %entry
  ret i32 0
}
