target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @disko_export_song(i32 %0, ptr %numfiles) {
entry:
  %tobool2 = icmp ne i32 %0, 0
  %cond = select i1 %tobool2, i32 64, i32 1
  store i32 %cond, ptr %numfiles, align 4
  %1 = load i32, ptr %numfiles, align 4
  %cmp = icmp sgt i32 %1, 1
  br i1 %cmp, label %if.then3, label %common.ret

common.ret:                                       ; preds = %if.then3, %entry
  ret i32 0

if.then3:                                         ; preds = %entry
  %conv5 = sext i32 0 to i64
  br label %common.ret
}
