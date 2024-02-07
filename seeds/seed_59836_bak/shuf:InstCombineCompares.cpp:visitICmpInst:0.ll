target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @randread() {
entry:
  br label %if.end

if.else:                                          ; No predecessors!
  call void @readisaac(i64 0, ptr null)
  br label %if.end

if.end:                                           ; preds = %if.else, %entry
  ret void
}

define internal void @readisaac(i64 %size, ptr %size.addr) {
entry:
  %cmp = icmp ule i64 1, %size
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret void

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %size.addr, align 8
  br label %common.ret
}
