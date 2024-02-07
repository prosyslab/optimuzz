target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @randread() {
entry:
  br label %if.end

if.else:                                          ; No predecessors!
  call void @readisaac(i64 0)
  br label %if.end

if.end:                                           ; preds = %if.else, %entry
  ret void
}

define internal void @readisaac(i64 %0) {
entry:
  br label %while.body

while.body:                                       ; preds = %while.body, %entry
  %rem = urem i64 %0, 8
  %cmp10 = icmp eq i64 %rem, 0
  br i1 %cmp10, label %if.then11, label %while.body

if.then11:                                        ; preds = %while.body
  ret void
}
