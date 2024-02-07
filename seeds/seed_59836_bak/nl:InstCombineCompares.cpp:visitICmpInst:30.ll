target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.re_dfastate_t = type { i64, %struct.linebuffer, %struct.linebuffer, %struct.linebuffer, ptr, ptr, ptr, i8 }
%struct.linebuffer = type { i64, i64, ptr }

define internal ptr @re_acquire_state_context() {
entry:
  br label %return

if.end:                                           ; No predecessors!
  %call101 = call ptr @create_cd_newstate(ptr null, ptr null)
  br label %return

return:                                           ; preds = %if.end, %entry
  ret ptr null
}

define internal ptr @create_cd_newstate(ptr %newstate, ptr %0) {
entry:
  %1 = load ptr, ptr %newstate, align 8
  %nodes55 = getelementptr %struct.re_dfastate_t, ptr %0, i64 0, i32 1
  %cmp56 = icmp eq ptr %1, %nodes55
  br i1 %cmp56, label %if.then58, label %common.ret

common.ret:                                       ; preds = %if.then58, %entry
  ret ptr null

if.then58:                                        ; preds = %entry
  %call60 = call ptr @malloc()
  br label %common.ret
}

declare ptr @malloc()

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
