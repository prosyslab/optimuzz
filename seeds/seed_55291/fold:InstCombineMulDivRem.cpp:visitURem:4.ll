target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i64 @adjust_column(ptr %column.addr, i64 %0) {
entry:
  %column.addr1 = alloca i64, align 8
  br label %if.then

if.then:                                          ; preds = %entry
  br label %if.else

if.else:                                          ; preds = %if.then
  br label %if.else10

if.else10:                                        ; preds = %if.else
  br label %if.then14

if.then14:                                        ; preds = %if.else10
  %1 = load i64, ptr %column.addr, align 8
  %rem = urem i64 %0, 8
  %sub = sub i64 0, 8
  %add = add i64 0, 0
  store i64 %rem, ptr undef, align 8
  ret i64 0
}
