target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call101 = call i32 @compare(ptr null)
  ret i32 0
}

define internal i32 @compare(ptr %sf1) {
entry:
  %cmp = icmp eq ptr %sf1, null
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %sf1, align 8
  br label %common.ret
}
