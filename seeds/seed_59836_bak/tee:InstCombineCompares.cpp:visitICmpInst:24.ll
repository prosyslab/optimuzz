target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.then12:                                        ; No predecessors!
  %call24 = call i1 @tee_files()
  unreachable
}

define internal i1 @tee_files() {
entry:
  unreachable

while.cond:                                       ; preds = %while.cond
  %call1111 = call i32 @get_next_out(ptr null, i32 0)
  br label %while.cond
}

define internal i32 @get_next_out(ptr %idx.addr, i32 %0) {
entry:
  %inc = add nsw i32 %0, 1
  %cmp = icmp sle i32 %inc, 0
  br i1 %cmp, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret i32 0

for.body:                                         ; preds = %entry
  %1 = load ptr, ptr %idx.addr, align 8
  br label %common.ret
}
