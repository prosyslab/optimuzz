target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @mktime_internal(ptr %off, i64 %0) {
entry:
  %1 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 0, i64 %0)
  %2 = extractvalue { i64, i1 } %1, 0
  %3 = trunc i64 %2 to i32
  store i32 %3, ptr %off, align 4
  ret i64 0
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.ssub.with.overflow.i64(i64, i64) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
