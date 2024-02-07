target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %compression, i16 %0) {
entry:
  %conv186 = zext i16 %0 to i32
  %cmp187 = icmp eq i32 %conv186, 0
  br i1 %cmp187, label %if.then189, label %if.end190

if.then189:                                       ; preds = %entry
  store i16 0, ptr %compression, align 2
  br label %if.end190

if.end190:                                        ; preds = %if.then189, %entry
  ret i32 0
}
