target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @sprintf(ptr, ptr, ...)

define i32 @extract_or_test_files() {
entry:
  ret i32 0

if.end141:                                        ; No predecessors!
  %call1451 = call i32 @store_info(i8 0)
  br label %while.cond237

while.cond237:                                    ; preds = %while.cond237, %if.end141
  br label %while.cond237
}

define internal i32 @store_info(i8 %0) {
entry:
  %conv48 = zext i8 %0 to i32
  %rem = srem i32 %conv48, 10
  %call49 = call i32 (ptr, ptr, ...) @sprintf(ptr null, ptr null, ptr null, ptr null, i32 0, i32 %rem, i32 0, i32 0)
  ret i32 0
}
