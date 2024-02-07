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
  %call231 = call i32 @init_dfa(ptr null, i64 0, i1 false)
  br label %return

return:                                           ; preds = %if.end, %entry
  ret i32 0
}

define internal i32 @init_dfa(ptr %max_i18n_object_size, i64 %0, i1 %cmp18) {
entry:
  %cond30 = select i1 %cmp18, i64 %0, i64 0
  %cmp31 = icmp ult i64 0, %cond30
  br i1 %cmp31, label %cond.true32, label %common.ret

common.ret:                                       ; preds = %cond.true32, %entry
  ret i32 0

cond.true32:                                      ; preds = %entry
  %1 = load i64, ptr %max_i18n_object_size, align 8
  br label %common.ret
}
