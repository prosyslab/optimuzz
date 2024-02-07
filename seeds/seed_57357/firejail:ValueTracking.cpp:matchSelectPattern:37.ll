target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @checkcfg(ptr %arp_probes, i32 %0) {
entry:
  %cmp848 = icmp sle i32 %0, 0
  %or.cond = select i1 %cmp848, i1 false, i1 true
  br i1 %or.cond, label %errout, label %if.end854

if.end854:                                        ; preds = %entry
  %1 = load i32, ptr %arp_probes, align 4
  br label %errout

errout:                                           ; preds = %if.end854, %entry
  ret i32 0
}
