target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb6

sw.bb6:                                           ; preds = %sw.bb6, %entry
  br label %sw.bb6

for.end159:                                       ; No predecessors!
  call void @fix_output_parameters(ptr null)
  ret i32 0
}

define internal void @fix_output_parameters(ptr %before_max_width) {
entry:
  %0 = load i64, ptr %before_max_width, align 8
  %cmp47 = icmp slt i64 %0, 0
  %spec.store.select = select i1 %cmp47, i64 0, i64 %0
  store i64 %spec.store.select, ptr %before_max_width, align 8
  ret void
}
