target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @xstrtoumax() {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  br label %while.cond

if.then22:                                        ; No predecessors!
  %call691 = call i32 @bkm_scale(ptr null, i64 0)
  ret i32 0
}

define internal i32 @bkm_scale(ptr %scale_factor.addr, i64 %0) {
entry:
  %1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 1, i64 %0)
  %2 = extractvalue { i64, i1 } %1, 0
  store i64 %2, ptr %scale_factor.addr, align 8
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
