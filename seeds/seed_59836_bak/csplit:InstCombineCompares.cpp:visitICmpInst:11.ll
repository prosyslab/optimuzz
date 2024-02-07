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
  call void @delete_all_files(ptr null, i32 0)
  ret void
}

define internal void @delete_all_files(ptr %i, i32 %0) {
entry:
  %cmp = icmp sle i32 0, %0
  br i1 %cmp, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry
  %1 = load i32, ptr %i, align 4
  br label %common.ret
}
