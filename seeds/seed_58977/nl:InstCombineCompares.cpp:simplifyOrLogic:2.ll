target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal ptr @re_acquire_state_context() {
entry:
  br label %return

if.end:                                           ; No predecessors!
  %call101 = call ptr @create_cd_newstate(ptr null, i8 0)
  br label %return

return:                                           ; preds = %if.end, %entry
  ret ptr null
}

define internal ptr @create_cd_newstate(ptr %newstate, i8 %bf.load33) {
entry:
  %bf.clear35 = and i8 %bf.load33, 1
  %bf.set36 = or i8 %bf.clear35, 1
  store i8 %bf.set36, ptr %newstate, align 8
  ret ptr null
}

define internal i32 @re_search_internal() {
entry:
  br label %return

cond.true335:                                     ; No predecessors!
  %call339 = call i64 @check_matching()
  br label %return

return:                                           ; preds = %cond.true335, %entry
  ret i32 0
}

define internal i64 @check_matching() {
entry:
  br label %acquire_init_state_context.exit

if.then19.i:                                      ; No predecessors!
  %call21.i = call ptr @re_acquire_state_context()
  br label %acquire_init_state_context.exit

acquire_init_state_context.exit:                  ; preds = %if.then19.i, %entry
  ret i64 0
}

define internal i64 @re_search_stub() {
entry:
  br label %return

land.rhs:                                         ; No predecessors!
  %call96 = call i32 @re_search_internal()
  br label %return

return:                                           ; preds = %land.rhs, %entry
  ret i64 0
}

define i64 @rpl_re_search() {
entry:
  %call = call i64 @re_search_stub()
  ret i64 0
}
