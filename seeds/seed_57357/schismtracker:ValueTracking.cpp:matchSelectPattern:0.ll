target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @ymf262_init() {
entry:
  %call = call ptr @OPL3Create()
  ret ptr null
}

define internal ptr @OPL3Create() {
entry:
  %call = call i32 @OPL3_LockTable()
  ret ptr null
}

define internal i32 @OPL3_LockTable() {
entry:
  %call1 = call i32 @init_tables.2677(ptr null, double 0.000000e+00)
  ret i32 0
}

define internal i32 @init_tables.2677(ptr %m, double %0) {
entry:
  %cmp87 = fcmp oge double %0, 0.000000e+00
  %cond = select i1 %cmp87, i32 0, i32 1
  store i32 %cond, ptr %m, align 4
  ret i32 0
}
