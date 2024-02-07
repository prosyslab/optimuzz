target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @realloc(i64)

define ptr @archive_string_ensure(i64 %0) {
entry:
  %add13 = add i64 %0, 1
  %cmp15 = icmp eq i64 %add13, 0
  br i1 %cmp15, label %common.ret, label %if.end19

common.ret:                                       ; preds = %if.end19, %entry
  ret ptr null

if.end19:                                         ; preds = %entry
  %call24 = call ptr @realloc(i64 %add13)
  br label %common.ret
}
