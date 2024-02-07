target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @logputs() {
entry:
  call void @saved_append()
  ret void
}

define internal void @saved_append() {
entry:
  call void @saved_append_1(ptr null, i8 0)
  ret void
}

define internal void @saved_append_1(ptr %end.addr, i8 %0) {
entry:
  %cmp89 = icmp ne i8 %0, 0
  %frombool = zext i1 %cmp89 to i8
  store i8 %frombool, ptr %end.addr, align 1
  ret void
}
