target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @handle_key() {
entry:
  br label %if.end244

if.end10:                                         ; No predecessors!
  %call121 = call i32 @handle_key_global(ptr null)
  br label %if.end244

if.end244:                                        ; preds = %if.end10, %entry
  ret void
}

define internal i32 @handle_key_global(ptr %ins_mode) {
entry:
  %0 = load i32, ptr %ins_mode, align 8
  %cmp66 = icmp eq i32 %0, 14
  %1 = load i32, ptr %ins_mode, align 8
  %cmp68 = icmp eq i32 %1, 15
  %or.cond = select i1 %cmp66, i1 true, i1 %cmp68
  br i1 %or.cond, label %if.then69, label %common.ret

common.ret:                                       ; preds = %if.then69, %entry
  ret i32 0

if.then69:                                        ; preds = %entry
  store i32 0, ptr %ins_mode, align 4
  br label %common.ret
}
