target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sbcopy(ptr %sb.addr, ptr %0, i64 %1) {
entry:
  %add.ptr = getelementptr i8, ptr %0, i64 %1
  store ptr %add.ptr, ptr %sb.addr, align 8
  %2 = load ptr, ptr %sb.addr, align 8
  %cmp3 = icmp uge ptr %2, %sb.addr
  br i1 %cmp3, label %if.then5, label %if.end9

if.then5:                                         ; preds = %entry
  %3 = load ptr, ptr %sb.addr, align 8
  br label %if.end9

if.end9:                                          ; preds = %if.then5, %entry
  ret void
}
