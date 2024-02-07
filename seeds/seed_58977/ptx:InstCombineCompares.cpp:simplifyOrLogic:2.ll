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

for.end61:                                        ; No predecessors!
  %call63 = call ptr @re_acquire_state_context()
  br label %return

return:                                           ; preds = %for.end61, %entry
  ret i32 0
}

define internal ptr @re_acquire_state_context() {
entry:
  br label %return

for.end:                                          ; No predecessors!
  %call101 = call ptr @create_cd_newstate(ptr null, i8 0)
  br label %return

return:                                           ; preds = %for.end, %entry
  ret ptr null
}

define internal ptr @create_cd_newstate(ptr %newstate, i8 %bf.load33) {
entry:
  %bf.clear35 = and i8 %bf.load33, 1
  %bf.set36 = or i8 %bf.clear35, 1
  store i8 %bf.set36, ptr %newstate, align 8
  ret ptr null
}
