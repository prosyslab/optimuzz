target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @vis_work_16s() {
entry:
  br label %for.cond1

for.cond1:                                        ; preds = %for.cond1, %entry
  br label %for.cond1

if.then17:                                        ; No predecessors!
  call void @_vis_process()
  ret void
}

define internal void @_vis_process() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

for.end:                                          ; No predecessors!
  call void @_get_columns_from_fft.2150(ptr null, i32 0)
  br label %for.cond26

for.cond26:                                       ; preds = %for.cond26, %for.end
  br label %for.cond26
}

define internal void @_get_columns_from_fft.2150(ptr %i, i32 %0) {
entry:
  %rem = srem i32 %0, 4
  %cmp49 = icmp eq i32 %rem, 0
  br i1 %cmp49, label %if.then51, label %common.ret

common.ret:                                       ; preds = %if.then51, %entry
  ret void

if.then51:                                        ; preds = %entry
  %1 = load i32, ptr %i, align 4
  br label %common.ret
}
