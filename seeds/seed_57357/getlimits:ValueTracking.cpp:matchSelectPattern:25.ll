target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call21611 = call ptr @decimal_absval_add_one(ptr null)
  ret i32 0
}

define internal ptr @decimal_absval_add_one(ptr %result) {
entry:
  %0 = load ptr, ptr %result, align 8
  %cmp9 = icmp ult ptr null, %0
  %cond = select i1 %cmp9, ptr null, ptr %0
  store ptr %cond, ptr %result, align 8
  ret ptr null
}
