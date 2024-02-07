target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @rotate_backups(ptr %sb, i1 %cmp1) {
entry:
  %conv = zext i1 %cmp1 to i32
  %cmp2 = icmp eq i32 %conv, 0
  br i1 %cmp2, label %common.ret, label %if.end5

common.ret:                                       ; preds = %if.end5, %entry
  ret void

if.end5:                                          ; preds = %entry
  %0 = load i32, ptr %sb, align 8
  br label %common.ret
}
