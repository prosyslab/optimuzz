target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @path_search(ptr %plen) {
entry:
  %0 = load i64, ptr %plen, align 8
  %cmp = icmp ugt i64 %0, 5
  %spec.store.select = select i1 %cmp, i64 5, i64 %0
  store i64 %spec.store.select, ptr %plen, align 8
  ret i32 0
}
