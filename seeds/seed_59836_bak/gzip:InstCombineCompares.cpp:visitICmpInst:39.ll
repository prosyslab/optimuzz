target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @rpl_fprintf(ptr %output, ...) {
entry:
  %buf = alloca [2000 x i8], align 16
  %0 = load ptr, ptr %output, align 8
  %cmp7 = icmp ne ptr %0, %buf
  br i1 %cmp7, label %if.then8, label %if.end9

if.then8:                                         ; preds = %entry
  %1 = load ptr, ptr %output, align 8
  br label %if.end9

if.end9:                                          ; preds = %if.then8, %entry
  ret i32 0
}
