target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@rsync_sum = external dso_local global i64

define i64 @deflate() {
if.then163:
  call void @rsync_roll(ptr undef, i64 undef)
  ret i64 0
}

define internal void @rsync_roll(ptr %rsync_sum, i64 %0) {
entry:
  br label %if.end6

if.end6:                                          ; preds = %entry
  br label %for.cond7

for.cond7:                                        ; preds = %if.end6
  br label %for.body11

for.body11:                                       ; preds = %for.cond7
  br i1 true, label %land.lhs.true, label %if.end27

land.lhs.true:                                    ; preds = %for.body11
  %1 = load i64, ptr %rsync_sum, align 8
  %rem = urem i64 %0, 4096
  %cmp23 = icmp eq i64 %rem, 0
  br i1 %cmp23, label %if.then25, label %if.end27

if.then25:                                        ; preds = %land.lhs.true
  %2 = load i32, ptr undef, align 4
  br label %if.end27

if.end27:                                         ; preds = %if.then25, %land.lhs.true, %for.body11
  ret void
}
