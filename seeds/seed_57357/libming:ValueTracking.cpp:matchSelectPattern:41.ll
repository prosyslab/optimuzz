target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @SWFShape_drawScaledCubicTo() {
entry:
  call void @subdivideCubicLeft(ptr null, i1 false, i1 false)
  ret i32 0
}

define internal void @subdivideCubicLeft(ptr %t.addr, i1 %cmp, i1 %cmp1) {
entry:
  %or.cond1 = select i1 %cmp1, i1 %cmp, i1 false
  br i1 %or.cond1, label %if.then2, label %if.end3

if.then2:                                         ; preds = %entry
  %0 = load ptr, ptr %t.addr, align 8
  br label %if.end3

if.end3:                                          ; preds = %if.then2, %entry
  ret void
}
