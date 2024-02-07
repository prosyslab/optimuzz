target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @copyFaxFile(ptr %badrun, i16 %0) {
entry:
  %conv32 = zext i16 %0 to i32
  %cmp34 = icmp sgt i32 %conv32, 0
  br i1 %cmp34, label %if.then36, label %if.end37

if.then36:                                        ; preds = %entry
  %1 = load i16, ptr %badrun, align 2
  br label %if.end37

if.end37:                                         ; preds = %if.then36, %entry
  ret i32 0
}
