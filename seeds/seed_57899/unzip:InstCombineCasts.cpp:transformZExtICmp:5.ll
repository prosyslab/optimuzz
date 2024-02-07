target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @extract_or_test_files() {
entry:
  %call1451 = call i32 @store_info(ptr null, i32 0)
  ret i32 0
}

define internal i32 @store_info(ptr %0, i32 %conv1) {
entry:
  %and2 = and i32 %conv1, 8
  %cmp = icmp eq i32 %and2, 0
  %conv3 = zext i1 %cmp to i32
  %1 = trunc i32 %conv3 to i8
  store i8 %1, ptr %0, align 8
  ret i32 0
}
