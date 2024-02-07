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
  call void @close_output_file(ptr null, i1 false, i32 0)
  ret void
}

define internal void @close_output_file(ptr %unlink_ok, i1 %tobool18, i32 %0) {
entry:
  %cmp20 = icmp ne i32 %0, 0
  %or.cond = select i1 %tobool18, i1 %cmp20, i1 false
  br i1 %or.cond, label %if.then21, label %if.end23

if.then21:                                        ; preds = %entry
  %1 = load i32, ptr %unlink_ok, align 4
  br label %if.end23

if.end23:                                         ; preds = %if.then21, %entry
  ret void
}
