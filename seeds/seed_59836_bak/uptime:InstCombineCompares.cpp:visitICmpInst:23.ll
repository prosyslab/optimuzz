target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @uptime(i32 0)
  unreachable
}

define internal void @uptime(i32 %call) {
entry:
  %read_utmp_status = alloca i32, align 4
  %cmp = icmp slt i32 %call, 0
  %cond = select i1 %cmp, i32 1, i32 0
  store i32 %cond, ptr %read_utmp_status, align 4
  %0 = load i32, ptr %read_utmp_status, align 4
  %cmp1 = icmp ne i32 %0, 0
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call2 = call ptr @__errno_location()
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

declare ptr @__errno_location()
