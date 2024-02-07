target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @check_zipfile(ptr %h, i64 %conv28) {
entry:
  %cmp42 = icmp ne i64 %conv28, 0
  br i1 %cmp42, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %h, align 8
  br label %common.ret
}
