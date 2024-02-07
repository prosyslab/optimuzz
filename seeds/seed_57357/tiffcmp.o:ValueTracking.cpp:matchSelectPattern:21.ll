target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call18 = call i32 @tiffcmp()
  ret i32 0
}

define internal i32 @tiffcmp() {
entry:
  %call135 = call i32 @ContigCompare()
  ret i32 0
}

define internal i32 @ContigCompare() {
entry:
  call void @PrintIntDiff(ptr null)
  ret i32 0
}

define internal void @PrintIntDiff(ptr %sample.addr) {
entry:
  %0 = load i32, ptr %sample.addr, align 4
  %cmp = icmp slt i32 %0, 0
  %spec.store.select = select i1 %cmp, i32 0, i32 %0
  store i32 %spec.store.select, ptr %sample.addr, align 4
  ret void
}
