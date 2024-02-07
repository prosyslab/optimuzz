target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.glob_t = type { i64, ptr, i64, i32, ptr, ptr, ptr, ptr, ptr }

define ptr @filespec_path(ptr %globs, i64 %0, i1 %cmp15) {
entry:
  %cmp18 = icmp ugt i64 %0, 0
  %or.cond = select i1 %cmp15, i1 %cmp18, i1 false
  br i1 %or.cond, label %if.then20, label %common.ret

common.ret:                                       ; preds = %if.then20, %entry
  ret ptr null

if.then20:                                        ; preds = %entry
  %gl_pathv = getelementptr %struct.glob_t, ptr %globs, i32 0, i32 1
  br label %common.ret
}
