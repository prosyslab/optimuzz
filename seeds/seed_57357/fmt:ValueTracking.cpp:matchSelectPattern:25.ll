target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call53 = call i1 @fmt()
  ret i32 0
}

define internal i1 @fmt() {
entry:
  %call1 = call i32 @get_prefix(ptr null)
  ret i1 false
}

define internal i32 @get_prefix(ptr %in_column) {
entry:
  %0 = load i32, ptr %in_column, align 4
  %cmp2 = icmp sgt i32 %0, 0
  %. = select i1 %cmp2, i32 0, i32 %0
  store i32 %., ptr %in_column, align 4
  ret i32 0
}
