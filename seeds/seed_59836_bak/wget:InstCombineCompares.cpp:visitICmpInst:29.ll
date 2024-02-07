target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @cookie_jar_load(ptr %p, ptr %0, i64 %call137) {
entry:
  %add.ptr = getelementptr inbounds i8, ptr %0, i64 %call137
  %cmp138 = icmp ugt ptr %add.ptr, null
  br i1 %cmp138, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret void

land.lhs.true:                                    ; preds = %entry
  %1 = load ptr, ptr %p, align 8
  br label %common.ret
}
