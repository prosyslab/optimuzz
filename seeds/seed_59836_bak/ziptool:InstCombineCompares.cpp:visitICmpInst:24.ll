target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb13

sw.bb13:                                          ; preds = %sw.bb13, %entry
  br label %sw.bb13

if.end27:                                         ; No predecessors!
  br label %while.cond28

while.cond28:                                     ; preds = %while.cond28, %if.end27
  %call321 = call i32 @dispatch(ptr null, i32 0)
  br label %while.cond28
}

define internal i32 @dispatch(ptr %argc.addr, i32 %0) {
entry:
  %dec = add nsw i32 %0, -1
  %cmp7 = icmp slt i32 %dec, 0
  br i1 %cmp7, label %if.then9, label %common.ret

common.ret:                                       ; preds = %if.then9, %entry
  ret i32 0

if.then9:                                         ; preds = %entry
  %1 = load ptr, ptr %argc.addr, align 8
  br label %common.ret
}
