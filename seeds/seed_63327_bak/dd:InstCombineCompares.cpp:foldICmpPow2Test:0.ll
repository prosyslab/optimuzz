target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.timespec = type { i64, i64 }

define i64 @gethrxtime(i32 %call, ptr %ts) {
entry:
  %cmp = icmp eq i32 %call, 0
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i64 0

if.then:                                          ; preds = %entry
  %tv_sec = getelementptr %struct.timespec, ptr %ts, i32 0, i32 0
  br label %common.ret
}
