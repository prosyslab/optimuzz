target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @rpl_fseeko(ptr %fp.addr) {
entry:
  %cmp = icmp eq ptr %fp.addr, null
  br i1 %cmp, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret i32 0

land.lhs.true:                                    ; preds = %entry
  %0 = load ptr, ptr %fp.addr, align 8
  br label %common.ret
}
