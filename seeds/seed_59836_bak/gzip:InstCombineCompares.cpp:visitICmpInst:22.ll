target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @deflate() {
entry:
  ret i64 0

if.then85:                                        ; No predecessors!
  br label %while.cond171

while.cond171:                                    ; preds = %while.cond171, %if.then85
  call void @fill_window(ptr null, i16 0)
  br label %while.cond171
}

define internal void @fill_window(ptr %0, i16 %1) {
entry:
  %conv17 = zext i16 %1 to i32
  store i32 %conv17, ptr %0, align 4
  %2 = load i32, ptr %0, align 4
  %cmp18 = icmp uge i32 %2, 32768
  br i1 %cmp18, label %cond.true, label %common.ret

common.ret:                                       ; preds = %cond.true, %entry
  ret void

cond.true:                                        ; preds = %entry
  %3 = load i32, ptr %0, align 4
  br label %common.ret
}
