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

if.then84:                                        ; No predecessors!
  %call86 = call i32 @create_initial_state()
  br label %return

return:                                           ; preds = %if.then84, %entry
  ret i32 0
}

define internal i32 @create_initial_state() {
entry:
  br label %return

if.then49:                                        ; No predecessors!
  %call521 = call i32 @re_node_set_merge(ptr null, i64 0, ptr null)
  br label %return

return:                                           ; preds = %if.then49, %entry
  ret i32 0
}

define internal i32 @re_node_set_merge(ptr %dest.addr, i64 %0, ptr %id) {
entry:
  %sub39 = sub nsw i64 %0, 1
  store i64 %sub39, ptr %id, align 8
  %1 = load i64, ptr %id, align 8
  %cmp42 = icmp sge i64 %1, 0
  br i1 %cmp42, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret i32 0

for.body:                                         ; preds = %entry
  %2 = load ptr, ptr %dest.addr, align 8
  br label %common.ret
}
