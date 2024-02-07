target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @gettext()

define i32 @main(i1 %cmp47) {
entry:
  %conv49 = select i1 %cmp47, i64 2, i64 0
  %cmp77 = icmp ult i64 %conv49, 1
  br i1 %cmp77, label %if.then79, label %common.ret

common.ret:                                       ; preds = %if.then79, %entry
  ret i32 0

if.then79:                                        ; preds = %entry
  %call80 = call ptr @gettext()
  br label %common.ret
}
