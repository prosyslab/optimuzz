target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @dump(i1 false, i1 false)
  ret i32 0
}

define internal void @dump(i1 %cmp2, i1 %cmp5) {
entry:
  %or.cond = select i1 %cmp2, i1 %cmp5, i1 false
  br i1 %or.cond, label %land.lhs.true7, label %if.end14

land.lhs.true7:                                   ; preds = %entry
  %cmp95 = icmp ne i32 0, 0
  br label %if.end14

if.end14:                                         ; preds = %land.lhs.true7, %entry
  ret void
}
