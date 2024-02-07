target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.then:                                          ; No predecessors!
  %call1051 = call i32 @dd_copy(i64 0, i1 false)
  ret i32 0
}

declare ptr @__errno_location()

define internal i32 @dd_copy(i64 %0, i1 %tobool23) {
entry:
  %cond27 = select i1 %tobool23, i64 %0, i64 0
  %call28 = call i64 @iwrite()
  %cmp29.not = icmp eq i64 %call28, %cond27
  br i1 %cmp29.not, label %if.end34, label %if.then30

if.then30:                                        ; preds = %entry
  %call31 = call ptr @__errno_location()
  br label %if.end34

if.end34:                                         ; preds = %if.then30, %entry
  ret i32 0
}

declare i64 @iwrite()
