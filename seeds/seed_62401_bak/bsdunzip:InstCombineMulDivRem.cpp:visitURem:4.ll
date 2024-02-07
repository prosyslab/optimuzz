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
  %call501 = call i32 @extract2fd(i64 0, ptr null)
  br label %return

return:                                           ; preds = %if.then48, %entry
  ret void
}

declare void @info(ptr, ...)

define internal i32 @extract2fd(i64 %conv, ptr %spinner) {
entry:
  %rem3 = urem i64 %conv, 4
  %arrayidx = getelementptr [4 x i8], ptr %spinner, i64 0, i64 %rem3
  %0 = load i8, ptr %arrayidx, align 1
  %conv4 = sext i8 %0 to i32
  call void (ptr, ...) @info(ptr null, i32 %conv4)
  ret i32 0
}
