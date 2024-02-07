target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @mbslen(ptr %iter.addr.i, i8 %0) {
entry:
  %conv.i = zext i8 %0 to i32
  %cmp.i = icmp slt i32 %conv.i, 128
  br i1 %cmp.i, label %if.then2.i, label %common.ret

common.ret:                                       ; preds = %if.then2.i, %entry
  ret i64 0

if.then2.i:                                       ; preds = %entry
  %1 = load ptr, ptr %iter.addr.i, align 8
  br label %common.ret
}
