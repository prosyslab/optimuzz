target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @re_search_internal(ptr %right_lim) {
entry:
  %start.addr = alloca i64, align 8
  %last_start.addr = alloca i64, align 8
  %0 = load i64, ptr %last_start.addr, align 8
  %1 = load i64, ptr %start.addr, align 8
  %cmp141 = icmp slt i64 %0, %1
  %2 = load i64, ptr %start.addr, align 8
  %3 = load i64, ptr %last_start.addr, align 8
  %cond146 = select i1 %cmp141, i64 %2, i64 %3
  store i64 %cond146, ptr %right_lim, align 8
  ret i32 0
}

define internal i64 @re_search_stub() {
entry:
  %call961 = call i32 @re_search_internal(ptr null)
  ret i64 0
}

define i64 @rpl_re_search() {
entry:
  %call = call i64 @re_search_stub()
  ret i64 0
}
