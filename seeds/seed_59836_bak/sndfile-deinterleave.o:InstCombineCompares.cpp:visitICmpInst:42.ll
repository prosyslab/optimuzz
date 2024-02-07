target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call54, ptr %count, ptr %filename) {
entry:
  %conv = sext i32 %call54 to i64
  store i64 %conv, ptr %count, align 8
  %0 = load i64, ptr %count, align 8
  %cmp55 = icmp uge i64 %0, 1
  br i1 %cmp55, label %if.then57, label %if.end60

if.then57:                                        ; preds = %entry
  %arraydecay58 = getelementptr [520 x i8], ptr %filename, i64 0, i64 0
  br label %if.end60

if.end60:                                         ; preds = %if.then57, %entry
  ret i32 0
}
