target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %tag_items, i1 %tobool372) {
entry:
  %0 = load i32, ptr %tag_items, align 8
  %cond373 = select i1 %tobool372, i32 16, i32 0
  %cmp375 = icmp slt i32 %0, %cond373
  br i1 %cmp375, label %if.then377, label %common.ret

common.ret:                                       ; preds = %if.then377, %entry
  ret i32 0

if.then377:                                       ; preds = %entry
  %1 = load ptr, ptr %tag_items, align 8
  br label %common.ret
}
