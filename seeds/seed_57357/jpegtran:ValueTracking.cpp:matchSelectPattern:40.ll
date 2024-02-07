target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @keymatch(i16 %0) {
entry:
  %tobool.not = icmp eq i16 %0, 0
  br i1 %tobool.not, label %if.end18, label %if.then7

if.then7:                                         ; preds = %entry
  %call13 = tail call ptr @__ctype_tolower_loc()
  br label %if.end18

if.end18:                                         ; preds = %if.then7, %entry
  ret i32 0
}

declare ptr @__ctype_tolower_loc()
