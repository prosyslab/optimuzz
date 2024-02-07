target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @CmdFontShape(i1 %cmp29, i1 %cmp33) {
entry:
  %or.cond1 = select i1 %cmp33, i1 %cmp29, i1 false
  br i1 %or.cond1, label %if.then36, label %if.end37

if.then36:                                        ; preds = %entry
  %call = call ptr @getBraceParam()
  br label %if.end37

if.end37:                                         ; preds = %if.then36, %entry
  ret void
}

declare ptr @getBraceParam()
