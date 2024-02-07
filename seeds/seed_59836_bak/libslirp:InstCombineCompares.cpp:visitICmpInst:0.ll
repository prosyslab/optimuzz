target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @m_copy(ptr %n.addr, i64 %sub.ptr.lhs.cast) {
entry:
  %cmp = icmp sgt i64 0, %sub.ptr.lhs.cast
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  store i32 0, ptr %n.addr, align 4
  br label %common.ret
}
