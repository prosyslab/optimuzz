target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @xalloc_die() {
entry:
  call void @cleanup_fatal()
  unreachable
}

define internal void @cleanup_fatal() {
entry:
  call void @cleanup()
  unreachable
}

define internal void @cleanup() {
entry:
  call void @close_output_file(i32 0)
  ret void
}

define internal void @close_output_file(i32 %call) {
entry:
  %tobool1.not = icmp eq i32 %call, 0
  call void @llvm.assume(i1 %tobool1.not)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
