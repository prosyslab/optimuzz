target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.then45:                                        ; No predecessors!
  call void @unzip()
  unreachable
}

define internal void @unzip() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %if.then70, %entry
  ret void

if.then70:                                        ; No predecessors!
  call void @extract_stdout()
  br label %for.cond
}

define internal void @extract_stdout() {
entry:
  br label %return

if.then48:                                        ; No predecessors!
  %call501 = call i32 @extract2fd(ptr null, i32 0)
  br label %return

return:                                           ; preds = %if.then48, %entry
  ret void
}

define internal i32 @extract2fd(ptr %n, i32 %0) {
entry:
  %rem = srem i32 %0, 4
  %cmp1 = icmp eq i32 %rem, 0
  br i1 %cmp1, label %if.then2, label %if.end5

if.then2:                                         ; preds = %entry
  %1 = load i32, ptr %n, align 4
  br label %if.end5

if.end5:                                          ; preds = %if.then2, %entry
  ret i32 0
}
