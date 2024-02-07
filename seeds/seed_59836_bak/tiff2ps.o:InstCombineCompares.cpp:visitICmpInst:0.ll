target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @PSDataBW(i32 %call12, ptr %tif.addr) {
entry:
  %cmp13 = icmp ult i32 0, %call12
  br i1 %cmp13, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry
  %0 = load ptr, ptr %tif.addr, align 8
  br label %common.ret
}
