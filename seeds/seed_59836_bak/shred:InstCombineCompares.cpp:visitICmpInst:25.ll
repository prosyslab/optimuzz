target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @randread() {
entry:
  call void @readsource(ptr null, i64 0)
  ret void
}

define internal void @readsource(ptr %inbytes, i64 %0) {
entry:
  %sub = sub i64 1, %0
  %cmp = icmp eq i64 %sub, 0
  br i1 %cmp, label %common.ret, label %if.end

common.ret:                                       ; preds = %if.end, %entry
  ret void

if.end:                                           ; preds = %entry
  %1 = load ptr, ptr %inbytes, align 8
  br label %common.ret
}
