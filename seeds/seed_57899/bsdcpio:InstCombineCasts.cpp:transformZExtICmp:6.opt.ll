; ModuleID = 'seeds/seed_57899/bsdcpio:InstCombineCasts.cpp:transformZExtICmp:6.ll'
source_filename = "seeds/seed_57899/bsdcpio:InstCombineCasts.cpp:transformZExtICmp:6.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @__archive_rb_tree_remove_node() {
entry:
  call void @__archive_rb_tree_swap_prune_and_rebalance(ptr null, i64 0)
  ret void
}

define internal void @__archive_rb_tree_swap_prune_and_rebalance(ptr %standin.addr, i64 %0) {
entry:
  %1 = trunc i64 %0 to i32
  %2 = and i32 %1, 1
  %3 = xor i32 %2, 1
  store i32 %3, ptr %standin.addr, align 4
  ret void
}
