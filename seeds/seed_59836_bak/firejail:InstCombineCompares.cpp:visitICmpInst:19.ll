target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @syscalls_in_list() {
entry:
  %call = load i32, ptr @syscall_in_list, align 4
  ret void
}

define internal void @syscall_in_list() {
entry:
  %call = load i32, ptr @find_syscall, align 4
  ret void
}

define internal void @find_syscall() {
entry:
  %syscall.addr = alloca i32, align 4
  %ptr = alloca ptr, align 8
  %0 = load i32, ptr %syscall.addr, align 4
  %call = call i32 @abs(i32 %0)
  %cmp = icmp eq i32 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %ptr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

declare i32 @abs(i32)
