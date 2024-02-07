target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.smul.with.overflow.i64(i64, i64) #1

define i32 @wait_reading_process_output() {
if.then210:
  call void @fd_CLR(ptr undef)
  ret i32 0
}

define internal void @fd_CLR(ptr %arrayidx) {
entry:
  %fd.addr = alloca i32, align 4
  %0 = load i32, ptr %fd.addr, align 4
  %cmp = icmp sle i32 0, %0
  br i1 %cmp, label %land.lhs.true, label %cond.false

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, ptr undef, align 4
  %cmp1 = icmp slt i32 0, 1
  br i1 true, label %cond.true, label %cond.false

cond.true:                                        ; preds = %land.lhs.true
  br label %cond.end

cond.false:                                       ; preds = %land.lhs.true, %entry
  unreachable

cond.end:                                         ; preds = %cond.true
  %2 = load i32, ptr %fd.addr, align 4
  %rem = srem i32 %2, 64
  %sh_prom = zext i32 %rem to i64
  %shl = shl i64 1, %sh_prom
  %neg = xor i64 1, 0
  %arrayidx1 = getelementptr inbounds [16 x i64], ptr undef, i64 0, i64 undef
  %3 = load i64, ptr undef, align 8
  %and = and i64 1, 0
  store i64 %sh_prom, ptr %arrayidx, align 8
  ret void
}

attributes #0 = { argmemonly nofree nounwind willreturn }
attributes #1 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
