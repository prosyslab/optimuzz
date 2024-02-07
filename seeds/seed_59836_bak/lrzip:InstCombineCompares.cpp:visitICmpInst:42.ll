target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @unlink_files(ptr %control.addr, i8 %0) {
entry:
  %conv = sext i8 %0 to i32
  %tobool1 = icmp ne i32 %conv, 0
  br i1 %tobool1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %control.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}
