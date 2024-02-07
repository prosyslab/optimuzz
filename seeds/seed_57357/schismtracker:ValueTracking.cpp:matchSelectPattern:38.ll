target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @disko_sync() {
entry:
  %call121 = call i32 @disko_finish(double 0.000000e+00, i1 false, ptr null)
  ret i32 0
}

define internal i32 @disko_finish(double %0, i1 %cmp36, ptr %fmt) {
entry:
  %cmp33 = fcmp oge double %0, 1.000000e+00
  %or.cond = select i1 %cmp33, i1 %cmp36, i1 false
  br i1 %or.cond, label %if.then38, label %if.end41

if.then38:                                        ; preds = %entry
  %arraydecay = getelementptr inbounds [80 x i8], ptr %fmt, i64 0, i64 0
  br label %if.end41

if.end41:                                         ; preds = %if.then38, %entry
  ret i32 0
}
