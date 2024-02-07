target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @printf_parse(ptr %a_allocated, i64 %0, i1 %cmp222) {
entry:
  %cond228 = select i1 %cmp222, i64 %0, i64 0
  %cmp229 = icmp eq i64 %cond228, 0
  br i1 %cmp229, label %common.ret, label %if.end232

common.ret:                                       ; preds = %if.end232, %entry
  ret i32 0

if.end232:                                        ; preds = %entry
  %1 = load ptr, ptr %a_allocated, align 8
  br label %common.ret
}
