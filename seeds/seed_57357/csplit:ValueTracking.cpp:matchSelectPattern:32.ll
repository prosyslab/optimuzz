target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @xstrtoumax() {
entry:
  %call691 = call i32 @bkm_scale.211(i32 0, i64 0)
  ret i32 0
}

define internal i32 @bkm_scale.211(i32 %0, i64 %op.sext) {
entry:
  %op.sext2 = sext i32 %0 to i64
  %1 = icmp slt i64 %op.sext, 0
  %2 = sub i64 0, %op.sext2
  %3 = select i1 %1, i64 %2, i64 %op.sext2
  %4 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %3, i64 0)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #0

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
