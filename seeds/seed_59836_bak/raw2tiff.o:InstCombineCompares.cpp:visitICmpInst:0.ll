target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb6

sw.bb6:                                           ; preds = %sw.bb6, %entry
  br label %sw.bb6

if.end146:                                        ; No predecessors!
  %call1471 = call i32 @guessSize(i32 0, ptr null)
  ret i32 0
}

define internal i32 @guessSize(i32 %call94, ptr %w) {
entry:
  %cmp95 = icmp eq i32 0, %call94
  br i1 %cmp95, label %if.then97, label %common.ret

common.ret:                                       ; preds = %if.then97, %entry
  ret i32 0

if.then97:                                        ; preds = %entry
  %0 = load i32, ptr %w, align 4
  br label %common.ret
}
