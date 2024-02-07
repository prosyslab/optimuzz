target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.then51:                                        ; No predecessors!
  br label %for.cond53

for.cond53:                                       ; preds = %for.cond53, %if.then51
  %call581 = call i32 @cart_dump(ptr null, i8 0)
  br label %for.cond53
}

define internal i32 @cart_dump(ptr %cart, i8 %0) {
entry:
  %tobool = icmp ne i8 %0, 0
  br i1 %tobool, label %if.then42, label %if.end52

if.then42:                                        ; preds = %entry
  %1 = load i32, ptr %cart, align 4
  br label %if.end52

if.end52:                                         ; preds = %if.then42, %entry
  ret i32 0
}
