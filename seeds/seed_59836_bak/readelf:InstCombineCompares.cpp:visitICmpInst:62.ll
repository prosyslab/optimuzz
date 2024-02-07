target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @sframe_encoder_write() {
entry:
  br label %return

if.end16:                                         ; No predecessors!
  %call21 = call i32 @sframe_encoder_write_sframe()
  br label %return

return:                                           ; preds = %if.end16, %entry
  ret ptr null
}

define internal i32 @sframe_encoder_write_sframe() {
entry:
  ret i32 0

for.cond17:                                       ; preds = %for.cond17
  %call251 = call i32 @sframe_encoder_write_fre(i64 0)
  br label %for.cond17
}

define internal i32 @sframe_encoder_write_fre(i64 %0) {
entry:
  %shl = shl i64 1, %0
  %sub = sub i64 %shl, 1
  %cmp = icmp ule i64 %0, %sub
  call void @llvm.assume(i1 %cmp)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
