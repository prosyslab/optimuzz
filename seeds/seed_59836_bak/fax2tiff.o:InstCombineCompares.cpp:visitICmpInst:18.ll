target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %rowbuf) {
entry:
  %cmp70 = icmp eq ptr %rowbuf, null
  %or.cond = select i1 %cmp70, i1 false, i1 true
  br i1 %or.cond, label %if.then74, label %common.ret

common.ret:                                       ; preds = %if.then74, %entry
  ret i32 0

if.then74:                                        ; preds = %entry
  %0 = load ptr, ptr %rowbuf, align 8
  br label %common.ret
}
