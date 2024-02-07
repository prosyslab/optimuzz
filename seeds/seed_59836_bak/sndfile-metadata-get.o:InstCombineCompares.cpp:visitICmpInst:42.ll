target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %argv.addr, i8 %0) {
entry:
  %conv = sext i8 %0 to i32
  %cmp10 = icmp ne i32 %conv, 0
  br i1 %cmp10, label %if.then12, label %common.ret

common.ret:                                       ; preds = %if.then12, %entry
  ret i32 0

if.then12:                                        ; preds = %entry
  %1 = load ptr, ptr %argv.addr, align 8
  br label %common.ret
}
