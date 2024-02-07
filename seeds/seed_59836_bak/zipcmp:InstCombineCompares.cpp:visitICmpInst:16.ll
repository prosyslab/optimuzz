target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb1

sw.bb1:                                           ; preds = %sw.bb1, %entry
  br label %sw.bb1

if.end:                                           ; No predecessors!
  %call161 = call i32 @compare_zip(ptr null, i64 0)
  unreachable
}

define internal i32 @compare_zip(ptr %a, i64 %0) {
entry:
  %cmp34 = icmp ugt i64 %0, 0
  br i1 %cmp34, label %if.then35, label %if.end42

if.then35:                                        ; preds = %entry
  %1 = load i32, ptr %a, align 4
  br label %if.end42

if.end42:                                         ; preds = %if.then35, %entry
  ret i32 0
}
