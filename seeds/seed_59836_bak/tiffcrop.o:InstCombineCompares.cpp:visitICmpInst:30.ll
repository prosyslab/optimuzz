target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @process_command_opts(ptr %mp.addr, ptr %0) {
entry:
  %1 = load ptr, ptr %mp.addr, align 8
  %add.ptr = getelementptr i8, ptr %0, i64 9
  %cmp103 = icmp ult ptr %1, %add.ptr
  call void @llvm.assume(i1 %cmp103)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
