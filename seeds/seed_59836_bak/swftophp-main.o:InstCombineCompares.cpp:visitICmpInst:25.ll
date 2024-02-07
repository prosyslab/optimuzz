target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @cws2fws(i64 %call86, ptr %_SWF_error) {
entry:
  %conv87 = trunc i64 %call86 to i32
  %cmp88 = icmp ne i32 %conv87, 0
  br i1 %cmp88, label %if.then90, label %common.ret

common.ret:                                       ; preds = %if.then90, %entry
  ret i32 0

if.then90:                                        ; preds = %entry
  %0 = load ptr, ptr %_SWF_error, align 8
  br label %common.ret
}
