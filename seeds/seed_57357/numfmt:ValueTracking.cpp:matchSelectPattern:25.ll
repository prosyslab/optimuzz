target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

define i64 @mbsalign() {
entry:
  %n_used_bytes = alloca i64, align 8
  %space_left = alloca i64, align 8
  %0 = load i64, ptr %n_used_bytes, align 8
  %1 = load i64, ptr %space_left, align 8
  %cmp76 = icmp ult i64 %0, %1
  %2 = load i64, ptr %n_used_bytes, align 8
  %3 = load i64, ptr %space_left, align 8
  %cond = select i1 %cmp76, i64 %2, i64 %3
  call void @llvm.memcpy.p0.p0.i64(ptr null, ptr null, i64 %cond, i1 false)
  ret i64 0
}

attributes #0 = { argmemonly nocallback nofree nounwind willreturn }
