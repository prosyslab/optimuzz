target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yyparse(ptr %size, i32 %0) {
entry:
  %rem = srem i32 %0, 8
  %tobool245 = icmp ne i32 %rem, 0
  br i1 %tobool245, label %if.then246, label %common.ret

common.ret:                                       ; preds = %if.then246, %entry
  ret i32 0

if.then246:                                       ; preds = %entry
  %1 = load ptr, ptr %size, align 8
  br label %common.ret
}
