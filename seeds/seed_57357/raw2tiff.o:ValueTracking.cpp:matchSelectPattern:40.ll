target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %fd, i32 %0) {
entry:
  %cmp134 = icmp slt i32 %0, 0
  br i1 %cmp134, label %if.then136, label %if.end141

if.then136:                                       ; preds = %entry
  %1 = load ptr, ptr %fd, align 8
  br label %if.end141

if.end141:                                        ; preds = %if.then136, %entry
  ret i32 0
}
