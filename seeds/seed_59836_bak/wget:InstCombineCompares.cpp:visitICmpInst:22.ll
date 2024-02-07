target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @remote_to_utf8(ptr %p, i8 %0) {
entry:
  %conv = zext i8 %0 to i32
  %cmp = icmp sgt i32 %conv, 127
  br i1 %cmp, label %if.then6, label %common.ret

common.ret:                                       ; preds = %if.then6, %entry
  ret i1 false

if.then6:                                         ; preds = %entry
  %1 = load ptr, ptr %p, align 8
  br label %common.ret
}
