target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @human_readable(ptr %tenths, i64 %0) {
entry:
  %mul1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %0, i64 1)
  %mul.ov = extractvalue { i64, i1 } %mul1, 1
  br i1 %mul.ov, label %common.ret, label %if.then21

common.ret:                                       ; preds = %if.then21, %entry
  ret ptr null

if.then21:                                        ; preds = %entry
  store i32 0, ptr %tenths, align 4
  br label %common.ret
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
