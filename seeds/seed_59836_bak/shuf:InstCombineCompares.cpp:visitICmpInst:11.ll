target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @randread() {
entry:
  br label %if.end

if.else:                                          ; No predecessors!
  call void @readisaac(ptr null, i64 0)
  br label %if.end

if.end:                                           ; preds = %if.else, %entry
  ret void
}

define internal void @readisaac(ptr %size.addr, i64 %0) {
entry:
  %cmp13 = icmp ule i64 1, %0
  br i1 %cmp13, label %while.body14, label %common.ret

common.ret:                                       ; preds = %while.body14, %entry
  ret void

while.body14:                                     ; preds = %entry
  %1 = load ptr, ptr %size.addr, align 8
  br label %common.ret
}
