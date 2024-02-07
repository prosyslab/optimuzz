target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @PSDataPalette(ptr %h.addr, i32 %0) {
entry:
  %cmp40 = icmp ult i32 0, %0
  br i1 %cmp40, label %for.body42, label %common.ret

common.ret:                                       ; preds = %for.body42, %entry
  ret void

for.body42:                                       ; preds = %entry
  %1 = load ptr, ptr %h.addr, align 8
  br label %common.ret
}
