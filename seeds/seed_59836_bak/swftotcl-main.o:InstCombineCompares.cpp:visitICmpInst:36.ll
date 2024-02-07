target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @cws2fws(ptr %_SWF_error) {
entry:
  %tobool = icmp ne ptr %_SWF_error, null
  br i1 %tobool, label %if.then2, label %if.end

if.then2:                                         ; preds = %entry
  %0 = load ptr, ptr %_SWF_error, align 8
  br label %if.end

if.end:                                           ; preds = %if.then2, %entry
  ret i32 0
}
