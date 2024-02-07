target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal void @fill_window(ptr %init) {
entry:
  %0 = load i64, ptr %init, align 8
  %cmp104 = icmp ugt i64 %0, 258
  %spec.store.select = select i1 %cmp104, i64 258, i64 %0
  store i64 %spec.store.select, ptr %init, align 8
  ret void
}

define i32 @deflate() {
entry:
  br label %return

cond.true113:                                     ; No predecessors!
  %call114 = call i32 @deflate_huff()
  br label %return

return:                                           ; preds = %cond.true113, %entry
  ret i32 0
}

define internal i32 @deflate_huff() {
entry:
  call void @fill_window(ptr null)
  ret i32 0
}
