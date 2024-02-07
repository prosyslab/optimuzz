target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @stdbuf, ptr null }]

define internal void @stdbuf() {
entry:
  %e_mode = alloca ptr, align 8
  %0 = load ptr, ptr %e_mode, align 8
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %e_mode, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}
