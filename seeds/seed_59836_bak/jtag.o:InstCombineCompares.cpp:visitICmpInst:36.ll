target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %0) {
entry:
  %tobool58.not = icmp eq ptr %0, null
  br i1 %tobool58.not, label %if.then59, label %common.ret

common.ret:                                       ; preds = %if.then59, %entry
  ret i32 0

if.then59:                                        ; preds = %entry
  %call60 = call ptr @gettext()
  br label %common.ret
}

declare ptr @gettext()
