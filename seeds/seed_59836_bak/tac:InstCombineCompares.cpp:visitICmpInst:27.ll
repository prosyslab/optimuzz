target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @re_compile_internal(i1 %0, i32 %call26, ptr %err) {
entry:
  br i1 %0, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %call262 = call i32 @pthread_mutex_init()
  br label %cond.end

cond.end:                                         ; preds = %cond.true, %entry
  %cond = phi i32 [ %call26, %cond.true ], [ 0, %entry ]
  %cmp27 = icmp ne i32 %cond, 0
  br i1 %cmp27, label %if.then31, label %if.end32

if.then31:                                        ; preds = %cond.end
  store i32 0, ptr %err, align 4
  br label %if.end32

if.end32:                                         ; preds = %if.then31, %cond.end
  ret i32 0
}

declare extern_weak i32 @pthread_mutex_init()

define i32 @rpl_regcomp() {
entry:
  br label %return

if.then9:                                         ; No predecessors!
  %call241 = call i32 @re_compile_internal(i1 false, i32 0, ptr null)
  br label %return

return:                                           ; preds = %if.then9, %entry
  ret i32 0
}
