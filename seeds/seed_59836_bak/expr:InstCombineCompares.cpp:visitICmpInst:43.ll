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
  %call231 = call i32 @init_dfa(ptr null)
  br label %return

return:                                           ; preds = %if.end, %entry
  ret i32 0
}

define internal i32 @init_dfa(ptr %max_i18n_object_size) {
entry:
  %0 = load i64, ptr %max_i18n_object_size, align 8
  %cmp40 = icmp ult i64 16, %0
  %1 = load i64, ptr %max_i18n_object_size, align 8
  %cond44 = select i1 %cmp40, i64 %1, i64 16
  %cmp48 = icmp ult i64 16, %cond44
  br i1 %cmp48, label %cond.true49, label %common.ret

common.ret:                                       ; preds = %cond.true49, %entry
  ret i32 0

cond.true49:                                      ; preds = %entry
  %2 = load i64, ptr %max_i18n_object_size, align 8
  br label %common.ret
}
