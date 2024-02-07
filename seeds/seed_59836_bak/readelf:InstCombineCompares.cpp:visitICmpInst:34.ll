target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @load_debug_section() {
entry:
  br label %return

if.then42:                                        ; No predecessors!
  %call441 = call i1 @load_specific_debug_section(ptr null, i1 false)
  br label %return

return:                                           ; preds = %if.then42, %entry
  ret i1 false
}

declare ptr @gettext()

define internal i1 @load_specific_debug_section(ptr %size18, i1 %tobool.not) {
entry:
  %0 = load i64, ptr %size18, align 8
  %cond = select i1 %tobool.not, i64 24, i64 0
  %cmp22 = icmp ult i64 %0, %cond
  br i1 %cmp22, label %if.then23, label %common.ret

common.ret:                                       ; preds = %if.then23, %entry
  ret i1 false

if.then23:                                        ; preds = %entry
  %call24 = call ptr @gettext()
  br label %common.ret
}
