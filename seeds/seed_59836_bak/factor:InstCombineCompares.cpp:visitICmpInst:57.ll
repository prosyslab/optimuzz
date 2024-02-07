target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

for.cond:                                         ; preds = %for.cond
  %call15 = call i1 @print_factors()
  br label %for.cond
}

define internal i1 @print_factors() {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  br label %while.cond

while.end:                                        ; No predecessors!
  switch i32 0, label %return [
    i32 0, label %sw.bb
    i32 1, label %for.cond
  ]

sw.bb:                                            ; preds = %while.end
  call void @print_factors_single()
  br label %return

for.cond:                                         ; preds = %for.cond, %while.end
  br label %for.cond

return:                                           ; preds = %sw.bb, %while.end
  ret i1 false
}

define internal void @print_factors_single() {
entry:
  call void @factor()
  ret void
}

define internal void @factor() {
entry:
  br label %if.end13

if.end6:                                          ; No predecessors!
  %call7 = call i1 @prime2_p()
  br label %if.end13

if.end13:                                         ; preds = %if.end6, %entry
  ret void
}

define internal i1 @prime2_p() {
entry:
  %call1 = call i1 @prime_p({ i64, i64 } zeroinitializer, ptr null)
  ret i1 false
}

define internal i1 @prime_p({ i64, i64 } %0, ptr %s1) {
entry:
  %asmresult96 = extractvalue { i64, i64 } %0, 1
  store i64 %asmresult96, ptr %s1, align 8
  %1 = load i64, ptr %s1, align 8
  %cmp97 = icmp eq i64 %1, 0
  br i1 %cmp97, label %if.then101, label %common.ret

common.ret:                                       ; preds = %if.then101, %entry
  ret i1 false

if.then101:                                       ; preds = %entry
  %2 = load i64, ptr %s1, align 8
  br label %common.ret
}
