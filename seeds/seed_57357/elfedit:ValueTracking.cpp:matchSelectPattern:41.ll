target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @buildargv(ptr %_sch_istable, i1 %tobool, i1 %tobool21) {
entry:
  %or.cond1 = select i1 %tobool, i1 false, i1 %tobool21
  br i1 %or.cond1, label %if.else27, label %land.lhs.true24

land.lhs.true24:                                  ; preds = %entry
  %0 = load i32, ptr %_sch_istable, align 4
  br label %if.else27

if.else27:                                        ; preds = %land.lhs.true24, %entry
  ret ptr null
}
