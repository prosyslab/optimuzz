target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %0, i1 %cmp67) {
entry:
  %cmp65 = icmp slt i32 %0, 0
  %or.cond = select i1 %cmp65, i1 %cmp67, i1 false
  br i1 %or.cond, label %if.then68, label %common.ret

common.ret:                                       ; preds = %if.then68, %entry
  ret i32 0

if.then68:                                        ; preds = %entry
  %call69 = call ptr @gettext()
  br label %common.ret
}

declare ptr @gettext()
