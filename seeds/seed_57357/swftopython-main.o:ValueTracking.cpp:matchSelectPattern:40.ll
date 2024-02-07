target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @cws2fws(ptr %_SWF_error) {
entry:
  %tobool57 = icmp ne ptr %_SWF_error, null
  br i1 %tobool57, label %if.then58, label %if.end59

if.then58:                                        ; preds = %entry
  %0 = load ptr, ptr %_SWF_error, align 8
  br label %if.end59

if.end59:                                         ; preds = %if.then58, %entry
  ret i32 0
}
