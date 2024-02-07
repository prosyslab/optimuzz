target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ParseAiffHeaderConfig(ptr %supported, i16 %0) {
entry:
  %tobool260.not = icmp eq i16 %0, 0
  %cmp264 = icmp ugt i16 %0, 256
  %or.cond = select i1 %tobool260.not, i1 true, i1 %cmp264
  br i1 %or.cond, label %if.then266, label %if.end267

if.then266:                                       ; preds = %entry
  store i32 0, ptr %supported, align 4
  br label %if.end267

if.end267:                                        ; preds = %if.then266, %entry
  ret i32 0
}
