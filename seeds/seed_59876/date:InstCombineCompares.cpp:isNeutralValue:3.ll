target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i32, i1 } @llvm.smul.with.overflow.i32(i32, i32) #0

define i64 @nstrftime() {
entry:
  %call = call i64 @__strftime_internal.391()
  ret i64 0
}

define internal i64 @__strftime_internal.391() {
entry:
  br label %do.body59

do.body59:                                        ; preds = %do.body59, %entry
  %width.addr.0 = phi i32 [ 0, %entry ], [ %1, %do.body59 ]
  %0 = call { i32, i1 } @llvm.smul.with.overflow.i32(i32 %width.addr.0, i32 1)
  %1 = extractvalue { i32, i1 } %0, 0
  br label %do.body59
}

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
