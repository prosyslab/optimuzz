target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @mktime_internal(ptr %call18) {
entry:
  %tobool = icmp ne ptr %call18, null
  br i1 %tobool, label %common.ret, label %if.then19

common.ret:                                       ; preds = %if.then19, %entry
  ret i64 0

if.then19:                                        ; preds = %entry
  store i64 0, ptr %call18, align 8
  br label %common.ret
}
