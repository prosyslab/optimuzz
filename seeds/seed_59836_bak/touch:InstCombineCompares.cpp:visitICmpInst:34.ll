target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @nstrftime() {
entry:
  %call1 = call i64 @__strftime_internal(ptr null, i1 false, i64 0)
  ret i64 0
}

define internal i64 @__strftime_internal(ptr %pad, i1 %cmp14, i64 %0) {
entry:
  %conv18 = select i1 %cmp14, i64 0, i64 %0
  %1 = load i64, ptr %pad, align 8
  %cmp19 = icmp ult i64 %1, %conv18
  %cond24 = select i1 %cmp19, i64 1, i64 0
  store i64 %cond24, ptr %pad, align 8
  ret i64 0
}
