target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @deflate() {
entry:
  ret i64 0

if.end:                                           ; No predecessors!
  call void @rsync_roll(ptr null, i64 0)
  br label %do.body56

do.body56:                                        ; preds = %do.body56, %if.end
  br label %do.body56
}

define internal void @rsync_roll(ptr %rsync_sum, i64 %0) {
entry:
  %rem = urem i64 %0, 4096
  %cmp23 = icmp eq i64 %rem, 0
  br i1 %cmp23, label %if.then25, label %if.end27

if.then25:                                        ; preds = %entry
  %1 = load i32, ptr %rsync_sum, align 4
  br label %if.end27

if.end27:                                         ; preds = %if.then25, %entry
  ret void
}
