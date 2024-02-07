target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @salvage_file(i64 0)
  ret i32 0
}

define internal void @salvage_file(i64 %0) {
entry:
  %cmp10 = icmp sle i64 %0, 0
  br i1 %cmp10, label %if.then11, label %if.end13

if.then11:                                        ; preds = %entry
  %call12 = call i32 (...) @printf()
  br label %if.end13

if.end13:                                         ; preds = %if.then11, %entry
  ret void
}

declare i32 @printf(...)
