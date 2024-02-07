target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @MD5_Update(ptr %saved_lo, i32 %0) {
entry:
  %cmp = icmp ult i32 0, %0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %saved_lo, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}
