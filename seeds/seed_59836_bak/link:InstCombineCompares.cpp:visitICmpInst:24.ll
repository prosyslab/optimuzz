target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @gettext()

define i32 @main(i32 %0) {
entry:
  %add4 = add nsw i32 %0, 1
  %cmp5 = icmp slt i32 0, %add4
  br i1 %cmp5, label %if.then6, label %common.ret

common.ret:                                       ; preds = %if.then6, %entry
  ret i32 0

if.then6:                                         ; preds = %entry
  %call7 = call ptr @gettext()
  br label %common.ret
}
