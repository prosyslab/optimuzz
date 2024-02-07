target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call15311 = call i32 @tiffcp(ptr null, i1 false, i1 false)
  ret i32 0
}

define internal i32 @tiffcp(ptr %compression, i1 %cmp266, i1 %cmp269) {
entry:
  %or.cond = select i1 %cmp266, i1 %cmp269, i1 false
  br i1 %or.cond, label %if.then271, label %if.end278

if.then271:                                       ; preds = %entry
  %0 = load ptr, ptr %compression, align 8
  br label %if.end278

if.end278:                                        ; preds = %if.then271, %entry
  ret i32 0
}
