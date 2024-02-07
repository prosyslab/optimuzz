target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.220 = private constant [2 x i8] c"C\00"

declare i32 @strcmp(ptr, ptr)

define i1 @hard_locale(ptr %locale) {
entry:
  %locale1 = alloca [257 x i8], align 16
  %call2 = call i32 @strcmp(ptr %locale1, ptr @.str.220)
  %cmp = icmp eq i32 %call2, 0
  br i1 %cmp, label %if.end7, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %arraydecay3 = getelementptr [257 x i8], ptr %locale, i64 0, i64 0
  br label %if.end7

if.end7:                                          ; preds = %lor.lhs.false, %entry
  ret i1 false
}
