target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call1) {
entry:
  %cmp2 = icmp ne i32 %call1, 0
  br i1 %cmp2, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %call3 = call ptr @gettext()
  br label %common.ret
}

declare ptr @gettext()
