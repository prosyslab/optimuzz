target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call2171 = call i32 @computeOutputPixelOffsets(ptr null)
  ret i32 0
}

define internal i32 @computeOutputPixelOffsets(ptr %orows) {
entry:
  %0 = load i32, ptr %orows, align 4
  %cmp246 = icmp ult i32 %0, 1
  %spec.store.select = select i1 %cmp246, i32 1, i32 %0
  store i32 %spec.store.select, ptr %orows, align 4
  ret i32 0
}
