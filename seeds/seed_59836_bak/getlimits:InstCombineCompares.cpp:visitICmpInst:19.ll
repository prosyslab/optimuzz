target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call91 = call ptr @decimal_absval_add_one(ptr null, ptr null)
  ret i32 0
}

define internal ptr @decimal_absval_add_one(ptr %absnum, ptr %p) {
entry:
  %0 = load ptr, ptr %absnum, align 8
  %1 = load ptr, ptr %p, align 8
  %cmp9 = icmp ult ptr %0, %1
  %cond = select i1 %cmp9, ptr %0, ptr %1
  store i8 0, ptr %cond, align 1
  ret ptr null
}
