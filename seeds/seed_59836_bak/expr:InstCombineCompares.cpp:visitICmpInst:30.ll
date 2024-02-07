target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.re_dfastate_t = type { i64, %struct.re_node_set, %struct.re_node_set, %struct.re_node_set, ptr, ptr, ptr, i8 }
%struct.re_node_set = type { i64, i64, ptr }

define ptr @rpl_re_compile_pattern() {
entry:
  %call = call i32 @re_compile_internal()
  ret ptr null
}

define internal i32 @re_compile_internal() {
entry:
  br label %return

re_compile_internal_free_return:                  ; No predecessors!
  call void @free_dfa_content()
  br label %return

return:                                           ; preds = %re_compile_internal_free_return, %entry
  ret i32 0
}

define internal void @free_dfa_content() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

for.cond38:                                       ; preds = %for.cond38
  call void @free_state(ptr null, ptr null)
  br label %for.cond38
}

define internal void @free_state(ptr %state.addr, ptr %0) {
entry:
  %1 = load ptr, ptr %state.addr, align 8
  %nodes = getelementptr %struct.re_dfastate_t, ptr %0, i32 0, i32 1
  %cmp = icmp ne ptr %1, %nodes
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load ptr, ptr %state.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}
