target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @fchdir()

define ptr @rpl_fts_read() {
entry:
  br label %return

if.end283:                                        ; No predecessors!
  %call2991 = call i32 @restore_initial_cwd(i1 false, i32 0)
  br label %return

return:                                           ; preds = %if.end283, %entry
  ret ptr null
}

define internal i32 @restore_initial_cwd(i1 %cmp3, i32 %call) {
entry:
  br i1 %cmp3, label %cond.end17, label %cond.false8

cond.false8:                                      ; preds = %entry
  %call2 = call i32 @fchdir()
  br label %cond.end17

cond.end17:                                       ; preds = %cond.false8, %entry
  %cond18 = phi i32 [ %call, %cond.false8 ], [ 0, %entry ]
  %tobool = icmp ne i32 %cond18, 0
  %land.ext = zext i1 %tobool to i32
  ret i32 %land.ext
}
