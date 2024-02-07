target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #0

define void @handle_key() {
entry:
  %call1 = call i32 @_handle_ime(i32 0)
  ret void
}

define internal i32 @_handle_ime(i32 %0) {
entry:
  %and235 = and i32 %0, 1
  %cmp236 = icmp sgt i32 %and235, 0
  br i1 %cmp236, label %if.then238, label %common.ret

common.ret:                                       ; preds = %if.then238, %entry
  ret i32 0

if.then238:                                       ; preds = %entry
  call void @llvm.memset.p0.i64(ptr null, i8 0, i64 0, i1 false)
  br label %common.ret
}

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: write) }
