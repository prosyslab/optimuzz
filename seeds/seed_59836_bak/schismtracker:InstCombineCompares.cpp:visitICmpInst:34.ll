target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @csf_write_sample(ptr %flags.addr, i32 %0, i1 %tobool26) {
entry:
  %and23 = and i32 %0, 1
  %cond27 = select i1 %tobool26, i32 16, i32 0
  %cmp28 = icmp ne i32 %and23, %cond27
  br i1 %cmp28, label %if.then29, label %common.ret

common.ret:                                       ; preds = %if.then29, %entry
  ret i32 0

if.then29:                                        ; preds = %entry
  %1 = load i32, ptr %flags.addr, align 4
  br label %common.ret
}
