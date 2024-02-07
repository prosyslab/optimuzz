target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @diff_output_file(ptr %name.addr, i8 %0) {
entry:
  %conv = sext i8 %0 to i32
  %cmp3 = icmp ne i32 %conv, 0
  br i1 %cmp3, label %land.lhs.true5, label %common.ret

common.ret:                                       ; preds = %land.lhs.true5, %entry
  ret void

land.lhs.true5:                                   ; preds = %entry
  %1 = load ptr, ptr %name.addr, align 8
  br label %common.ret
}
