target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

cond.true278:                                     ; No predecessors!
  switch i32 0, label %sw.default300 [
    i32 0, label %sw.bb291
  ]

sw.bb291:                                         ; preds = %cond.true278
  call void @line_bytes_split(ptr null, i1 false, i64 0)
  unreachable

sw.default300:                                    ; preds = %cond.true278
  unreachable
}

define internal void @line_bytes_split(ptr %eoc, i1 %tobool60, i64 %0) {
entry:
  %cond64 = select i1 %tobool60, i64 %0, i64 0
  %1 = load i64, ptr %eoc, align 8
  %cmp66 = icmp slt i64 %1, %cond64
  br i1 %cmp66, label %if.then67, label %if.end71

if.then67:                                        ; preds = %entry
  %2 = load ptr, ptr %eoc, align 8
  br label %if.end71

if.end71:                                         ; preds = %if.then67, %entry
  ret void
}
