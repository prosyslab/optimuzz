target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %progname) {
entry:
  %cmp = icmp eq ptr %progname, null
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %0 = load ptr, ptr %progname, align 8
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  ret i32 0
}
