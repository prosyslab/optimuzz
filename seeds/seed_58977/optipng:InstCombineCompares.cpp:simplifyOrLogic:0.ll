target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_combine_row(i32 %0) {
entry:
  %not383 = xor i32 %0, -1
  %or385 = or i32 %0, %not383
  %conv386 = trunc i32 %or385 to i8
  ret void
}
