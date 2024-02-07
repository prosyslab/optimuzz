target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @set_process_security_ctx() {
entry:
  br label %return

lor.lhs.false25:                                  ; No predecessors!
  %call291 = call i1 @errno_unsupported(i32 0)
  br label %return

return:                                           ; preds = %lor.lhs.false25, %entry
  ret i1 false
}

define internal i1 @errno_unsupported(i32 %0) {
entry:
  %cmp = icmp eq i32 %0, 0
  %1 = select i1 %cmp, i1 false, i1 true
  ret i1 %1
}
