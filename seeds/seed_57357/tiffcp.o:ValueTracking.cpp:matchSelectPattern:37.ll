target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call1531 = call i32 @tiffcp(ptr null, i32 0, i1 false)
  ret i32 0
}

define internal i32 @tiffcp(ptr %rowsperstrip, i32 %0, i1 %cmp151) {
entry:
  %cmp148 = icmp ugt i32 %0, 0
  %or.cond = select i1 %cmp148, i1 %cmp151, i1 false
  br i1 %or.cond, label %if.then153, label %if.end154

if.then153:                                       ; preds = %entry
  %1 = load i32, ptr %rowsperstrip, align 4
  br label %if.end154

if.end154:                                        ; preds = %if.then153, %entry
  ret i32 0
}
