target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @__ctype_b_loc()

define i32 @zstrnicmp(i32 %call3) {
entry:
  %conv5 = trunc i32 %call3 to i8
  %conv6 = sext i8 %conv5 to i32
  %conv21 = trunc i32 %call3 to i8
  %conv22 = sext i8 %conv21 to i32
  %cmp23 = icmp ne i32 %conv6, %conv22
  br i1 %cmp23, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %call25 = call ptr @__ctype_b_loc()
  br label %common.ret
}
