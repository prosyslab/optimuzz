target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @RtfFontNumber(ptr %call1) {
entry:
  %cmp = icmp ne ptr %call1, null
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %entry
  %0 = load ptr, ptr %call1, align 8
  br label %while.end

while.end:                                        ; preds = %while.body, %entry
  ret i32 0
}
