target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @__ctype_b_loc()

define i32 @read_scan_script(i1 %cmp12.not.i, ptr %call1.i, i1 %cmp.lcssa.i) {
entry:
  br i1 %cmp12.not.i, label %if.else.i, label %while.body.i144

while.body.i144:                                  ; preds = %entry
  %0 = load ptr, ptr %call1.i, align 8
  br label %if.else.i

if.else.i.critedge:                               ; preds = %if.else.i
  %call1.i1.c = tail call ptr @__ctype_b_loc()
  br label %if.else.i

if.else.i:                                        ; preds = %if.else.i.critedge, %while.body.i144, %entry
  %spec.select = select i1 %cmp.lcssa.i, i32 1, i32 0
  %cmp9 = icmp eq i32 %spec.select, 0
  br i1 %cmp12.not.i, label %if.else.i.critedge, label %while.end.loopexit

while.end.loopexit:                               ; preds = %if.else.i
  ret i32 0
}
