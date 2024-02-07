target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb5

sw.bb5:                                           ; preds = %sw.bb5, %entry
  br label %sw.bb5

if.end16:                                         ; No predecessors!
  br label %while.cond17

while.cond17:                                     ; preds = %while.cond17, %if.end16
  %call18 = call i32 @tiffcmp()
  br label %while.cond17
}

define internal i32 @tiffcmp() {
entry:
  unreachable

for.cond116:                                      ; No predecessors!
  call void @leof(ptr null, i32 0)
  unreachable
}

define internal void @leof(ptr %s.addr, i32 %0) {
entry:
  %cmp = icmp sge i32 %0, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load i32, ptr %s.addr, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}
