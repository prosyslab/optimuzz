target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @instrument_set() {
entry:
  call void @instrument_list_reposition(ptr null)
  ret void
}

define internal void @instrument_list_reposition(ptr %current_instrument) {
entry:
  %0 = load i32, ptr %current_instrument, align 4
  %cmp1 = icmp slt i32 %0, 0
  %spec.select = select i1 %cmp1, i32 0, i32 %0
  store i32 %spec.select, ptr %current_instrument, align 4
  ret void
}
