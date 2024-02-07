target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i64 %conv172, ptr %wid) {
entry:
  br label %while.cond163

while.cond163:                                    ; preds = %while.cond163, %entry
  %tobool173 = icmp ne i64 %conv172, 0
  %cond174 = select i1 %tobool173, i32 0, i32 1
  store i32 %cond174, ptr %wid, align 4
  br label %while.cond163
}
