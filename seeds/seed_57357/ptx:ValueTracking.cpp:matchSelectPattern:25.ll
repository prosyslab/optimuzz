target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @rpl_re_compile_pattern() {
entry:
  %call = call i32 @re_compile_internal()
  ret ptr null
}

define internal i32 @re_compile_internal() {
entry:
  %call231 = call i32 @init_dfa(ptr null)
  ret i32 0
}

define internal i32 @init_dfa(ptr %max_i18n_object_size) {
entry:
  %0 = load i64, ptr %max_i18n_object_size, align 8
  %cmp13 = icmp ult i64 16, %0
  %1 = load i64, ptr %max_i18n_object_size, align 8
  %cond17 = select i1 %cmp13, i64 %1, i64 16
  %cmp18 = icmp ult i64 0, %cond17
  br i1 %cmp18, label %cond.true19, label %cond.false28

cond.true19:                                      ; preds = %entry
  %2 = load i64, ptr %max_i18n_object_size, align 8
  br label %cond.false28

cond.false28:                                     ; preds = %cond.true19, %entry
  ret i32 0
}
