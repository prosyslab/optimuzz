target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call25, i1 %tobool26, ptr %stderr) {
entry:
  %cmp27 = icmp ne i32 %call25, 0
  %or.cond = select i1 %tobool26, i1 false, i1 %cmp27
  br i1 %or.cond, label %if.then29, label %common.ret

common.ret:                                       ; preds = %if.then29, %entry
  ret i32 0

if.then29:                                        ; preds = %entry
  %0 = load ptr, ptr %stderr, align 8
  br label %common.ret
}
