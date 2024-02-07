target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @opng_sprint_uratio_impl(ptr %scale, i32 %0) {
entry:
  %cmp9 = icmp uge i32 0, %0
  br i1 %cmp9, label %if.then11, label %if.end13

if.then11:                                        ; preds = %entry
  %1 = load i32, ptr %scale, align 4
  br label %if.end13

if.end13:                                         ; preds = %if.then11, %entry
  ret i32 0
}

define i32 @opng_ulratio_to_percent_string() {
entry:
  %call1 = call i32 @opng_sprint_uratio_impl(ptr null, i32 0)
  ret i32 0
}
