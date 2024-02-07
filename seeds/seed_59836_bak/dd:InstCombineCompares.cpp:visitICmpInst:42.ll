target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @human_readable(ptr %buf.addr, i8 %0) {
entry:
  %conv80 = sext i8 %0 to i32
  %cmp81 = icmp eq i32 %conv80, 0
  br i1 %cmp81, label %if.then83, label %if.end89

if.then83:                                        ; preds = %entry
  %1 = load ptr, ptr %buf.addr, align 8
  br label %if.end89

if.end89:                                         ; preds = %if.then83, %entry
  ret ptr null
}
