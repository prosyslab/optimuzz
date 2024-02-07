target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @get_subimage_count(ptr %imagewidth.addr, double %0) {
entry:
  %cmp = fcmp olt double %0, 0.000000e+00
  %or.cond = select i1 %cmp, i1 false, i1 true
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, ptr %imagewidth.addr, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i32 0
}
