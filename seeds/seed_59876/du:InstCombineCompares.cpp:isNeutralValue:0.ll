target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @rpl_fts_read() {
entry:
  br label %return

if.end136:                                        ; No predecessors!
  %call1461 = call ptr @fts_build(ptr null, i64 0)
  br label %return

return:                                           ; preds = %if.end136, %entry
  ret ptr null
}

define internal ptr @fts_build(ptr %len, i64 %0) {
entry:
  %add291 = add i64 %0, 1
  %cmp292 = icmp ult i64 %add291, 1
  %spec.store.select = select i1 %cmp292, i64 %add291, i64 0
  store i64 %spec.store.select, ptr %len, align 8
  ret ptr null
}
