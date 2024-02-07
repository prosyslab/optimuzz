target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call1811 = call i32 @tiffcmp(i1 false, i1 false)
  ret i32 0
}

define internal i32 @tiffcmp(i1 %cmp29, i1 %cmp32) {
entry:
  %or.cond = select i1 %cmp29, i1 %cmp32, i1 false
  br i1 %or.cond, label %land.lhs.true34, label %if.end40

land.lhs.true34:                                  ; preds = %entry
  %cmp366 = icmp sgt i32 0, 0
  br label %if.end40

if.end40:                                         ; preds = %land.lhs.true34, %entry
  ret i32 0
}
