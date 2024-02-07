target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call2, ptr %argv.addr) {
entry:
  %cmp3 = icmp eq i32 %call2, 0
  br i1 %cmp3, label %if.then, label %lor.lhs.false4

lor.lhs.false4:                                   ; preds = %entry
  %0 = load ptr, ptr %argv.addr, align 8
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false4, %entry
  ret i32 0
}
