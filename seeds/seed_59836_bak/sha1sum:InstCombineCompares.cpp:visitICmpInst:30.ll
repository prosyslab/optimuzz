target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @rpl_fopen(ptr %q, ptr %fdopen_mode_buf) {
entry:
  %0 = load ptr, ptr %q, align 8
  %add.ptr = getelementptr i8, ptr %fdopen_mode_buf, i64 80
  %cmp4 = icmp ult ptr %0, %add.ptr
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %q, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret ptr null
}
