target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %infilename, i8 %0) {
entry:
  %conv = sext i8 %0 to i32
  %cmp14 = icmp eq i32 %conv, 0
  br i1 %cmp14, label %if.then16, label %if.end18

if.then16:                                        ; preds = %entry
  %1 = load ptr, ptr %infilename, align 8
  br label %if.end18

if.end18:                                         ; preds = %if.then16, %entry
  ret i32 0
}
