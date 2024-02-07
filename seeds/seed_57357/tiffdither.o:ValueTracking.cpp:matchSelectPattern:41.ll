target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call1261 = call i32 @fsdither(ptr null, i1 false, i1 false)
  ret i32 0
}

define internal i32 @fsdither(ptr %inputline, i1 %tobool, i1 %tobool23) {
entry:
  %or.cond1 = select i1 %tobool23, i1 %tobool, i1 false
  br i1 %or.cond1, label %land.lhs.true26, label %if.then

land.lhs.true26:                                  ; preds = %entry
  %0 = load ptr, ptr %inputline, align 8
  br label %if.then

if.then:                                          ; preds = %land.lhs.true26, %entry
  ret i32 0
}
