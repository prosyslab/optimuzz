target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @canonicalize_filename_mode() {
entry:
  %call1 = call ptr @canonicalize_filename_mode_stk(ptr null, i64 0)
  ret ptr null
}

define internal ptr @canonicalize_filename_mode_stk(ptr %end, i64 %sub.ptr.lhs.cast) {
entry:
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, 1
  %cmp49 = icmp eq i64 %sub.ptr.sub, 0
  br i1 %cmp49, label %if.then51, label %common.ret

common.ret:                                       ; preds = %if.then51, %entry
  ret ptr null

if.then51:                                        ; preds = %entry
  %0 = load ptr, ptr %end, align 8
  br label %common.ret
}
