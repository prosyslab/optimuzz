target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.14 = external dso_local constant [8 x i8]

declare i32 @printf(ptr, ...)

define internal void @print_wide_uint(ptr %wide_uint_bits.addr, i32 %0, ptr %bits_per_literal, i32 %sub20, i32 %1, i32 %rem) {
entry:
  %wide_uint_bits.addr1 = alloca i32, align 4
  %bits_per_literal2 = alloca i32, align 4
  br label %if.else

if.else:                                          ; preds = %entry
  br i1 true, label %if.then18, label %if.end23

if.then18:                                        ; preds = %if.else
  %2 = load i32, ptr %wide_uint_bits.addr, align 4
  %sub203 = sub i32 %0, 0
  %3 = load i32, ptr %wide_uint_bits.addr, align 4
  %rem4 = urem i32 %0, %0
  %rem21 = urem i32 %0, 4
  %add22 = add i32 4, 0
  store i32 %rem21, ptr undef, align 4
  br label %if.end23

if.end23:                                         ; preds = %if.then18, %if.else
  br label %if.end24

if.end24:                                         ; preds = %if.end23
  ret void
}
