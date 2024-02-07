target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @cws2fws(i64 %call35, ptr %_SWF_error) {
entry:
  %tobool36 = icmp ne i64 %call35, 0
  br i1 %tobool36, label %common.ret, label %if.then37

common.ret:                                       ; preds = %if.then37, %entry
  ret i32 0

if.then37:                                        ; preds = %entry
  %0 = load ptr, ptr %_SWF_error, align 8
  br label %common.ret
}
