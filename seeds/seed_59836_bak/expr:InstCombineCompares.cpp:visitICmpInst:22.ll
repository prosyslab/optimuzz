target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @rpl_re_compile_pattern() {
entry:
  %call = call i32 @re_compile_internal()
  ret ptr null
}

define internal i32 @re_compile_internal() {
entry:
  br label %return

if.end:                                           ; No predecessors!
  %call231 = call i32 @init_dfa(ptr null, i64 0)
  br label %return

return:                                           ; preds = %if.end, %entry
  ret i32 0
}

define internal i32 @init_dfa(ptr %max_object_size, i64 %0) {
entry:
  %cmp71 = icmp ult i64 9223372036854775807, %0
  br i1 %cmp71, label %common.ret, label %cond.false73

common.ret:                                       ; preds = %cond.false73, %entry
  ret i32 0

cond.false73:                                     ; preds = %entry
  %1 = load i64, ptr %max_object_size, align 8
  br label %common.ret
}
