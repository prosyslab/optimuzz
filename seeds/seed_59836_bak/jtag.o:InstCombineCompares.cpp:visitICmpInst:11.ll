target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %0) {
entry:
  %cmp102 = icmp uge i32 0, %0
  br i1 %cmp102, label %if.then103, label %if.end106

if.then103:                                       ; preds = %entry
  %call104 = call ptr @gettext()
  br label %if.end106

if.end106:                                        ; preds = %if.then103, %entry
  ret i32 0
}

declare ptr @gettext()
