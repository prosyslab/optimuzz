target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @rpl_mbrtowc(ptr %ret, i64 %0) {
entry:
  %cmp = icmp ule i64 1, %0
  br i1 %cmp, label %land.lhs.true, label %if.end5

land.lhs.true:                                    ; preds = %entry
  %1 = load i64, ptr %ret, align 8
  br label %if.end5

if.end5:                                          ; preds = %land.lhs.true, %entry
  ret i64 0
}
