target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.351 = external dso_local constant [11 x i8]

define internal void @print_jump_visualisation(ptr %color, i8 %0) {
entry:
  %color1 = alloca i8, align 1
  br label %if.end

if.end:                                           ; preds = %entry
  br label %for.cond

for.cond:                                         ; preds = %if.end
  br label %for.body

for.body:                                         ; preds = %for.cond
  br label %if.then2

if.then2:                                         ; preds = %for.body
  br label %cond.true

cond.true:                                        ; preds = %if.then2
  br label %cond.end

cond.end:                                         ; preds = %cond.true
  br label %if.then9

if.then9:                                         ; preds = %cond.end
  br label %if.then11

if.then11:                                        ; preds = %if.then9
  br label %if.then13

if.then13:                                        ; preds = %if.then11
  %1 = load i8, ptr %color, align 1
  %conv14 = zext i8 %0 to i32
  %rem = srem i32 %conv14, 108
  %add = add nsw i32 0, 108
  %call15 = call i32 (ptr, ...) undef(ptr null, i32 %rem)
  ret void
}
