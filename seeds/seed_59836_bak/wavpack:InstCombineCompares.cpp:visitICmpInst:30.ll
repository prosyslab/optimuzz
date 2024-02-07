target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ImportID3v2(ptr %cp, ptr %0) {
entry:
  %1 = load ptr, ptr %cp, align 8
  %add.ptr2 = getelementptr i8, ptr %0, i64 -10
  %cmp3 = icmp ult ptr %1, %add.ptr2
  br i1 %cmp3, label %while.body, label %common.ret

common.ret:                                       ; preds = %while.body, %entry
  ret i32 0

while.body:                                       ; preds = %entry
  %2 = load ptr, ptr %cp, align 8
  br label %common.ret
}
