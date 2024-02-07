target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.else152:                                       ; No predecessors!
  %call1531 = call i1 @do_ftruncate(ptr null)
  br i1 false, label %for.inc, label %for.inc

for.inc:                                          ; preds = %for.inc, %if.else152, %if.else152
  br label %for.inc
}

define internal i1 @do_ftruncate(ptr %nsize) {
entry:
  %0 = load i64, ptr %nsize, align 8
  %cmp78 = icmp slt i64 %0, 0
  %spec.store.select = select i1 %cmp78, i64 0, i64 %0
  store i64 %spec.store.select, ptr %nsize, align 8
  ret i1 false
}
