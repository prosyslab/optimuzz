target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @process_command_opts(ptr %opt_ptr, i1 %cmp76) {
entry:
  %cmp74 = icmp ne ptr %opt_ptr, null
  %0 = select i1 %cmp74, i1 %cmp76, i1 false
  br i1 %0, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry
  %1 = load ptr, ptr %opt_ptr, align 8
  br label %common.ret
}
