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
  call void @close_output_file(ptr null)
  ret void
}

define internal void @close_output_file(ptr %output_stream) {
entry:
  %tobool = icmp ne ptr %output_stream, null
  br i1 %tobool, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret void

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %output_stream, align 8
  br label %common.ret
}
