target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @blake2b_init(ptr %retval, i64 %0) {
entry:
  %tobool = icmp eq i64 %0, 0
  %cmp = icmp ugt i64 %0, 64
  %or.cond = select i1 %tobool, i1 true, i1 %cmp
  br i1 %or.cond, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  store i32 0, ptr %retval, align 4
  br label %common.ret
}
