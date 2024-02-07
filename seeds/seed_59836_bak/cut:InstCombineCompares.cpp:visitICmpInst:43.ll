target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @freadseek(ptr %buffered, i64 %0, i64 %1) {
entry:
  %cond = call i64 @llvm.umin.i64(i64 %0, i64 %1)
  %cmp7 = icmp eq i64 %0, %cond
  br i1 %cmp7, label %common.ret, label %if.end9

common.ret:                                       ; preds = %if.end9, %entry
  ret i32 0

if.end9:                                          ; preds = %entry
  %2 = load i64, ptr %buffered, align 8
  br label %common.ret
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umin.i64(i64, i64) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
