target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #0

define i1 @gl_dynarray_resize(ptr %size.addr, i64 %0) {
entry:
  %1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %0, i64 1)
  %2 = extractvalue { i64, i1 } %1, 0
  store i64 %2, ptr %size.addr, align 8
  ret i1 false
}

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
