target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @pin_sandbox_process() {
entry:
  call void @check_joinable()
  ret ptr null
}

define internal void @check_joinable() {
entry:
  %call11 = call i1 @has_join_file(ptr null, i1 false, i1 false)
  ret void
}

define internal i1 @has_join_file(ptr %s, i1 %cmp7, i1 %cmp8) {
entry:
  %brmerge = select i1 %cmp7, i1 false, i1 %cmp8
  br i1 %brmerge, label %if.then11, label %if.end13

if.then11:                                        ; preds = %entry
  %0 = load i32, ptr %s, align 4
  br label %if.end13

if.end13:                                         ; preds = %if.then11, %entry
  ret i1 false
}
