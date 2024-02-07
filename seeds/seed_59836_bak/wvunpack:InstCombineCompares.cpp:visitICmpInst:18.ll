target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @WriteAiffHeader(ptr %aifc, i32 %0) {
entry:
  %tobool69 = icmp ne i32 %0, 0
  %cond = select i1 %tobool69, ptr %aifc, ptr null
  call void @llvm.memcpy.p0.p0.i64(ptr null, ptr %cond, i64 0, i1 false)
  ret i32 0
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
