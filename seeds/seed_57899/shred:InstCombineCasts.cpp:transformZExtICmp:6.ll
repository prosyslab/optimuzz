target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @human_readable(ptr %opts.addr, i32 %0, i64 %1) {
entry:
  %and71 = and i32 %0, 1
  %tobool72 = icmp ne i32 %and71, 0
  %lnot = xor i1 %tobool72, true
  %lnot.ext = zext i1 %lnot to i32
  %conv73 = sext i32 %lnot.ext to i64
  %cmp75 = icmp ult i64 %conv73, %1
  br i1 %cmp75, label %if.then83, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %2 = load i32, ptr %opts.addr, align 4
  br label %if.then83

if.then83:                                        ; preds = %lor.lhs.false, %entry
  ret ptr null
}
