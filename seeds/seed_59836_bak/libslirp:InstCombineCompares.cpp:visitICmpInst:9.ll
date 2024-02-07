target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @tcp_input(ptr %tp, i1 %cmp1292) {
entry:
  %conv1293 = zext i1 %cmp1292 to i32
  %cmp1294 = icmp eq i32 %conv1293, 0
  br i1 %cmp1294, label %if.then1296, label %common.ret

common.ret:                                       ; preds = %if.then1296, %entry
  ret void

if.then1296:                                      ; preds = %entry
  %0 = load ptr, ptr %tp, align 8
  br label %common.ret
}
