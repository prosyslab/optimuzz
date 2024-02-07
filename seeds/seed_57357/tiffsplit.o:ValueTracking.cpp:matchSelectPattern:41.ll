target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call551 = call i32 @tiffcp(ptr null, i1 false, i1 false)
  ret i32 0
}

define internal i32 @tiffcp(ptr %count, i1 %tobool43, i1 %cmp44) {
entry:
  %or.cond1 = select i1 %cmp44, i1 %tobool43, i1 false
  br i1 %or.cond1, label %if.then48, label %if.end50

if.then48:                                        ; preds = %entry
  %0 = load ptr, ptr %count, align 8
  br label %if.end50

if.end50:                                         ; preds = %if.then48, %entry
  ret i32 0
}
