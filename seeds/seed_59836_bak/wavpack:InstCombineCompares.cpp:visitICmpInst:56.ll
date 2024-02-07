target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @MD5_Update(ptr %used, i64 %0) {
entry:
  %tobool = icmp ne i64 %0, 0
  br i1 %tobool, label %if.then10, label %common.ret

common.ret:                                       ; preds = %if.then10, %entry
  ret void

if.then10:                                        ; preds = %entry
  %1 = load i64, ptr %used, align 8
  br label %common.ret
}
