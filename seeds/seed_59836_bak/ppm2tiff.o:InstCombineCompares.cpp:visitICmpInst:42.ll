target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.6 = private constant [5 x i8] c" \09\0D\0A\00"

define i32 @main(i32 %0) {
entry:
  br label %while.body42

while.body42:                                     ; preds = %while.body42, %entry
  %call48 = call ptr @strchr(ptr @.str.6, i32 %0)
  %tobool49 = icmp ne ptr %call48, null
  br i1 %tobool49, label %while.body42, label %if.end51

if.end51:                                         ; preds = %while.body42
  ret i32 0
}

declare ptr @strchr(ptr, i32)
