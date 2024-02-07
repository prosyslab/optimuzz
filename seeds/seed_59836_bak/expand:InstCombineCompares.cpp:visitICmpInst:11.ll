target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @set_program_name(ptr %argv0.addr, i64 %sub.ptr.rhs.cast) {
entry:
  %cmp3 = icmp sge i64 %sub.ptr.rhs.cast, 0
  br i1 %cmp3, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret void

land.lhs.true:                                    ; preds = %entry
  %0 = load ptr, ptr %argv0.addr, align 8
  br label %common.ret
}
