target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @process_command_opts(ptr %c, i32 %0) {
entry:
  %cond = icmp eq i32 %0, 0
  br i1 %cond, label %common.ret, label %sw.bb

common.ret:                                       ; preds = %sw.bb, %entry
  ret void

sw.bb:                                            ; preds = %entry
  %1 = load ptr, ptr %c, align 8
  br label %common.ret
}
