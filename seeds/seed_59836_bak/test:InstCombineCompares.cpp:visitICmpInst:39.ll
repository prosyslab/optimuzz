target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @vasnprintf(ptr %tmp) {
entry:
  %tmpbuf = alloca [700 x i8], align 16
  %0 = load ptr, ptr %tmp, align 8
  %cmp981 = icmp ne ptr %0, %tmpbuf
  br i1 %cmp981, label %if.then983, label %if.end984

if.then983:                                       ; preds = %entry
  %1 = load ptr, ptr %tmp, align 8
  br label %if.end984

if.end984:                                        ; preds = %if.then983, %entry
  ret ptr null
}
