target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %0, i1 %cmp166) {
entry:
  br label %while.cond163

while.cond163:                                    ; preds = %while.cond163, %entry
  %cmp164 = icmp sgt i32 %0, 0
  %1 = select i1 %cmp164, i1 %cmp166, i1 false
  br i1 %1, label %while.cond163, label %while.end177

while.end177:                                     ; preds = %while.cond163
  ret i32 0
}
