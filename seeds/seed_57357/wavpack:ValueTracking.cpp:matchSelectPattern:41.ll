target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: argmemonly nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #0

define i32 @ImportID3v2() {
entry:
  %call11 = call fastcc i32 @ImportID3v2_syncsafe(i1 false, i1 false)
  ret i32 0
}

define internal fastcc i32 @ImportID3v2_syncsafe(i1 %tobool89, i1 %tobool91) {
entry:
  %or.cond653 = select i1 %tobool89, i1 %tobool91, i1 false
  br i1 %or.cond653, label %common.ret, label %while.end639

common.ret:                                       ; preds = %while.end639, %entry
  ret i32 0

while.end639:                                     ; preds = %entry
  call void @llvm.lifetime.end.p0(i64 0, ptr null)
  br label %common.ret
}

attributes #0 = { argmemonly nocallback nofree nosync nounwind willreturn }
