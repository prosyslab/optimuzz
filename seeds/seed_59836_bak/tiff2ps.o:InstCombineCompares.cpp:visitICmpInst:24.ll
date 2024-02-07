target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@ascii85count = external global i32

define void @Ascii85Put(ptr %ascii85count, i32 %0) {
entry:
  %inc = add nsw i32 %0, 1
  store i32 %inc, ptr @ascii85count, align 4
  %1 = load i32, ptr @ascii85count, align 4
  %cmp = icmp sge i32 %1, 0
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret void

if.then:                                          ; preds = %entry
  %2 = load i32, ptr %ascii85count, align 4
  br label %common.ret
}
