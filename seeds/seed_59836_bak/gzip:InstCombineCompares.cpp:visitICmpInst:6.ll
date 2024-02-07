target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.timespec = type { i64, i64 }

define i32 @fdutimens(ptr %timespec.addr, i1 %tobool, ptr %adjusted_timespec, ptr %ts) {
entry:
  %cond = select i1 %tobool, ptr %timespec.addr, ptr null
  store ptr %cond, ptr %ts, align 8
  %0 = load ptr, ptr %ts, align 8
  %tobool1 = icmp ne ptr %0, null
  br i1 %tobool1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %arrayidx = getelementptr [2 x %struct.timespec], ptr %adjusted_timespec, i64 0, i64 0
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i32 0
}
