target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @mktime_internal() {
entry:
  %call601 = call i1 @isdst_differ(ptr null, i1 false, i1 false)
  ret i64 0
}

define internal i1 @isdst_differ(ptr %a.addr, i1 %tobool, i1 %lnot) {
entry:
  %or.cond = select i1 %lnot, i1 %tobool, i1 false
  br i1 %or.cond, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %entry
  %0 = load i32, ptr %a.addr, align 4
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  ret i1 false
}
