target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @Ascii85EncodeBlock(ptr %val32, i32 %0) {
entry:
  %cmp12 = icmp eq i32 %0, 0
  br i1 %cmp12, label %if.then14, label %if.else

if.then14:                                        ; preds = %entry
  %1 = load ptr, ptr %val32, align 8
  br label %if.else

if.else:                                          ; preds = %if.then14, %entry
  ret i64 0
}
