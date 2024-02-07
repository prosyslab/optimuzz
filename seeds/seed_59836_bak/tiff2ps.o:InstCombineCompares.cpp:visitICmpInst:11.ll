target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @Ascii85EncodeBlock(ptr %rc, i32 %0) {
entry:
  %cmp39 = icmp sle i32 %0, 0
  br i1 %cmp39, label %if.then41, label %if.end43

if.then41:                                        ; preds = %entry
  %1 = load ptr, ptr %rc, align 8
  br label %if.end43

if.end43:                                         ; preds = %if.then41, %entry
  ret i64 0
}
