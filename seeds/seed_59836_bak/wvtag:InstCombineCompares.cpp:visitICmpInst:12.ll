target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @copy_timestamp(i32 %call3, ptr %retval) {
entry:
  %tobool = icmp ne i32 %call3, 0
  br i1 %tobool, label %if.then4, label %common.ret

common.ret:                                       ; preds = %if.then4, %entry
  ret i32 0

if.then4:                                         ; preds = %entry
  store i32 0, ptr %retval, align 4
  br label %common.ret
}
