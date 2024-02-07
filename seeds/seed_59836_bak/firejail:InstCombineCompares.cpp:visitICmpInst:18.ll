target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @prctl(...)

define void @caps_drop_dac_override(i32 %call) {
entry:
  %cmp = icmp ne i32 %call, 0
  %or.cond = select i1 %cmp, i1 false, i1 true
  br i1 %or.cond, label %common.ret, label %if.then

common.ret:                                       ; preds = %if.then, %entry
  ret void

if.then:                                          ; preds = %entry
  %call12 = call i32 (...) @prctl()
  br label %common.ret
}
