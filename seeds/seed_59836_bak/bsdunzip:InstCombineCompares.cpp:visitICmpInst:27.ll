target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @__archive_rb_tree_insert_node() {
entry:
  br label %return

cond.true:                                        ; No predecessors!
  call void @__archive_rb_tree_insert_rebalance(ptr null, i64 0, ptr null)
  br label %return

return:                                           ; preds = %cond.true, %entry
  ret i32 0
}

define internal void @__archive_rb_tree_insert_rebalance(ptr %self.addr, i64 %0, ptr %father) {
entry:
  %1 = inttoptr i64 %0 to ptr
  store ptr %1, ptr %father, align 8
  %2 = load ptr, ptr %father, align 8
  %cmp22 = icmp eq ptr %2, null
  br i1 %cmp22, label %if.then29, label %lor.lhs.false24

lor.lhs.false24:                                  ; preds = %entry
  %3 = load ptr, ptr %self.addr, align 8
  br label %if.then29

if.then29:                                        ; preds = %lor.lhs.false24, %entry
  ret void
}
