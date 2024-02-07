target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal ptr @Ascii85Encode(ptr %w1, i16 %0) {
entry:
  %w11 = alloca i16, align 2
  br label %if.then

if.then:                                          ; preds = %entry
  %1 = load i16, ptr %w1, align 2
  %conv42 = zext i16 %0 to i32
  %rem = srem i32 %conv42, 85
  %add43 = add nsw i32 85, 0
  %conv44 = trunc i32 %rem to i8
  store i8 %conv44, ptr poison, align 1
  ret ptr null
}
