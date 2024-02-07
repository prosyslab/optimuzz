target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.anon.61 = type { i32, i32 }

@posix_init.clocks = internal constant [2 x %struct.anon.61] [%struct.anon.61 { i32 1, i32 149 }, %struct.anon.61 { i32 0, i32 -1 }]

define ptr @ptimer_new() {
entry:
  br label %if.end

if.then:                                          ; No predecessors!
  call void @posix_init(i64 0)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret ptr null
}

define internal void @posix_init(i64 %0) {
entry:
  %arrayidx.phi.trans.insert = getelementptr [2 x %struct.anon.61], ptr @posix_init.clocks, i64 0, i64 %0
  %sysconf_name.phi.trans.insert = getelementptr %struct.anon.61, ptr %arrayidx.phi.trans.insert, i32 0, i32 1
  %.pre = load i32, ptr %sysconf_name.phi.trans.insert, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %cmp1 = icmp ne i32 %.pre, 0
  br i1 %cmp1, label %for.cond, label %if.end6

if.end6:                                          ; preds = %for.cond
  ret void
}
