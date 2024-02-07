target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @SWFBlockList_addBlock(ptr %list.addr, i32 %0) {
entry:
  %rem = srem i32 %0, 16
  %cmp = icmp eq i32 %rem, 0
  br i1 %cmp, label %if.then1, label %if.end5

if.then1:                                         ; preds = %entry
  %1 = load ptr, ptr %list.addr, align 8
  br label %if.end5

if.end5:                                          ; preds = %if.then1, %entry
  ret void
}
