target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb14

sw.bb14:                                          ; preds = %sw.bb14, %entry
  br label %sw.bb14

if.then56:                                        ; No predecessors!
  %call1261 = call i32 @fsdither(ptr null)
  ret i32 0
}

define internal i32 @fsdither(ptr %v) {
entry:
  %0 = load i32, ptr %v, align 4
  %cmp70 = icmp sgt i32 %0, 255
  %spec.store.select = select i1 %cmp70, i32 255, i32 %0
  store i32 %spec.store.select, ptr %v, align 4
  ret i32 0
}
