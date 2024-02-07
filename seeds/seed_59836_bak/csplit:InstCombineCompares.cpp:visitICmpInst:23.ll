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
  %call861 = call i32 @create_initial_state(ptr null, i8 0)
  br label %return

return:                                           ; preds = %if.then84, %entry
  ret i32 0
}

define internal i32 @create_initial_state(ptr %dfa.addr, i8 %bf.load72) {
entry:
  %bf.lshr = lshr i8 %bf.load72, 7
  %bf.cast = zext i8 %bf.lshr to i32
  %tobool73 = icmp ne i32 %bf.cast, 0
  br i1 %tobool73, label %if.then74, label %common.ret

common.ret:                                       ; preds = %if.then74, %entry
  ret i32 0

if.then74:                                        ; preds = %entry
  %0 = load ptr, ptr %dfa.addr, align 8
  br label %common.ret
}
