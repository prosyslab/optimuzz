target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %sfinfo, i32 %0) {
entry:
  switch i32 %0, label %sw.default [
    i32 6, label %sw.epilog
    i32 1, label %sw.epilog
    i32 0, label %sw.epilog
  ]

sw.default:                                       ; preds = %entry
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default, %entry, %entry, %entry
  %double_split.0 = phi i32 [ 0, %sw.default ], [ 1, %entry ], [ 1, %entry ], [ 1, %entry ]
  %tobool73 = icmp ne i32 %double_split.0, 0
  br i1 %tobool73, label %if.then74, label %common.ret

common.ret:                                       ; preds = %if.then74, %sw.epilog
  ret i32 0

if.then74:                                        ; preds = %sw.epilog
  %1 = load ptr, ptr %sfinfo, align 8
  br label %common.ret
}
