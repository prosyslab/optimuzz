target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ctf_hash_insert_type(ptr %name.addr, i32 %0) {
entry:
  %shr = lshr i32 %0, 31
  %cmp2 = icmp eq i32 %shr, 1
  br i1 %cmp2, label %land.lhs.true3, label %common.ret

common.ret:                                       ; preds = %land.lhs.true3, %entry
  ret i32 0

land.lhs.true3:                                   ; preds = %entry
  %1 = load ptr, ptr %name.addr, align 8
  br label %common.ret
}
