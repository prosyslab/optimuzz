target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %cond.end62

cond.false58:                                     ; No predecessors!
  %call611 = call i32 @send_signals(ptr null, i64 0)
  br label %cond.end62

cond.end62:                                       ; preds = %cond.false58, %entry
  ret i32 0
}

define internal i32 @send_signals(ptr %n, i64 %0) {
entry:
  %1 = trunc i64 %0 to i32
  %2 = sext i32 %1 to i64
  %3 = icmp ne i64 %0, %2
  br i1 %3, label %if.then, label %lor.lhs.false3

lor.lhs.false3:                                   ; preds = %entry
  %4 = load ptr, ptr %n, align 8
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false3, %entry
  ret i32 0
}
