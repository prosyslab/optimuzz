target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.then19:                                        ; No predecessors!
  br label %for.cond21

for.cond21:                                       ; preds = %for.cond21, %if.then19
  %call261 = call i32 @broadcast_dump(i32 0, i1 false)
  br label %for.cond21
}

define internal i32 @broadcast_dump(i32 %0, i1 %cmp25) {
entry:
  %cmp28 = icmp eq i32 %0, 0
  %or.cond = select i1 %cmp25, i1 %cmp28, i1 false
  br i1 %or.cond, label %if.then30, label %common.ret

common.ret:                                       ; preds = %if.then30, %entry
  ret i32 0

if.then30:                                        ; preds = %entry
  %call31 = call i32 (...) @printf()
  br label %common.ret
}

declare i32 @printf(...)
