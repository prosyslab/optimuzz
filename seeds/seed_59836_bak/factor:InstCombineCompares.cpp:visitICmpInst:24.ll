target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @__errno_location()

define ptr @str_cd_iconv(ptr %newsize) {
entry:
  %result_size = alloca i64, align 8
  %0 = load i64, ptr %result_size, align 8
  %mul16 = mul i64 %0, 2
  store i64 %mul16, ptr %newsize, align 8
  %1 = load i64, ptr %newsize, align 8
  %2 = load i64, ptr %result_size, align 8
  %cmp17 = icmp ugt i64 %1, %2
  br i1 %cmp17, label %common.ret, label %if.then18

common.ret:                                       ; preds = %if.then18, %entry
  ret ptr null

if.then18:                                        ; preds = %entry
  %call19 = call ptr @__errno_location()
  br label %common.ret
}
