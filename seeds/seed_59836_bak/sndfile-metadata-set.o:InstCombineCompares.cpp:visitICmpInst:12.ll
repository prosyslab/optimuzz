target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %conv, ptr %filenames) {
entry:
  %cmp11 = icmp ne i32 %conv, 0
  br i1 %cmp11, label %if.then13, label %common.ret

common.ret:                                       ; preds = %if.then13, %entry
  ret i32 0

if.then13:                                        ; preds = %entry
  %arrayidx14 = getelementptr [2 x ptr], ptr %filenames, i64 0, i64 0
  br label %common.ret
}
