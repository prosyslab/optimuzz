target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @archive_entry_copy_fflags_text() {
entry:
  %call21 = call ptr @ae_strtofflags(ptr null, i8 0)
  ret ptr null
}

define internal ptr @ae_strtofflags(ptr %start, i8 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %lor.lhs.false, %while.cond, %entry
  %conv = sext i8 %0 to i32
  %cmp = icmp eq i32 %conv, 0
  br i1 %cmp, label %while.cond, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %while.cond
  %1 = load ptr, ptr %start, align 8
  br label %while.cond
}
