target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %photometric, i32 %conv, i1 %cmp26) {
entry:
  %cmp29 = icmp ne i32 %conv, 0
  %or.cond = select i1 %cmp26, i1 %cmp29, i1 false
  br i1 %or.cond, label %if.then31, label %common.ret

common.ret:                                       ; preds = %if.then31, %entry
  ret i32 0

if.then31:                                        ; preds = %entry
  %0 = load ptr, ptr %photometric, align 8
  br label %common.ret
}
