target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @translate_dnssearch() {
entry:
  call void @domain_mklabels(ptr null, i1 false, i1 false)
  ret i32 0
}

define internal void @domain_mklabels(ptr %len, i1 %cmp9, i1 %cmp12) {
entry:
  %or.cond = select i1 %cmp9, i1 %cmp12, i1 false
  br i1 %or.cond, label %if.then17, label %lor.lhs.false14

lor.lhs.false14:                                  ; preds = %entry
  %0 = load i64, ptr %len, align 8
  br label %if.then17

if.then17:                                        ; preds = %lor.lhs.false14, %entry
  ret void
}
