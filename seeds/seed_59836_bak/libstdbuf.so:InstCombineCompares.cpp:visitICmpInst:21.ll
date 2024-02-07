target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @stdbuf, ptr null }]

define internal void @stdbuf() {
entry:
  call void @apply_mode(ptr null, i32 0)
  ret void
}

define internal void @apply_mode(ptr %mode.addr, i32 %conv) {
entry:
  %cmp = icmp eq i32 %conv, 0
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret void

if.then:                                          ; preds = %entry
  store i32 0, ptr %mode.addr, align 4
  br label %common.ret
}
