target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call34, ptr %stderr) {
entry:
  %add36 = add i32 %call34, 1
  %tobool37 = icmp ne i32 %add36, 0
  br i1 %tobool37, label %if.then38, label %common.ret

common.ret:                                       ; preds = %if.then38, %entry
  ret i32 0

if.then38:                                        ; preds = %entry
  %0 = load ptr, ptr %stderr, align 8
  br label %common.ret
}
