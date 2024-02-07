target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i1 @hard_locale()

define i64 @rpl_mbrtowc(i64 %0) {
entry:
  %cmp = icmp ule i64 %0, 0
  %or.cond = select i1 %cmp, i1 false, i1 true
  br i1 %or.cond, label %if.end5, label %land.lhs.true2

land.lhs.true2:                                   ; preds = %entry
  %call3 = call i1 @hard_locale()
  br label %if.end5

if.end5:                                          ; preds = %land.lhs.true2, %entry
  ret i64 0
}
