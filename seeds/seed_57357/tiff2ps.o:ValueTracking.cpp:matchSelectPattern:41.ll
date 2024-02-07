target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @TIFF2PS(ptr %maxPageHeight, i1 %tobool41, i1 %tobool42) {
entry:
  %or.cond1 = select i1 %tobool42, i1 false, i1 %tobool41
  br i1 %or.cond1, label %if.then49, label %lor.lhs.false46

lor.lhs.false46:                                  ; preds = %entry
  %0 = load double, ptr %maxPageHeight, align 8
  br label %if.then49

if.then49:                                        ; preds = %lor.lhs.false46, %entry
  ret i32 0
}
