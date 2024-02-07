target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.else296:                                       ; No predecessors!
  call void @bytes_chunk_extract(ptr null, i64 0)
  unreachable
}

define internal void @bytes_chunk_extract(ptr %k.addr, i64 %0) {
entry:
  %sub2 = sub nsw i64 %0, 1
  %cmp3 = icmp slt i64 %sub2, 0
  br i1 %cmp3, label %cond.true, label %common.ret

common.ret:                                       ; preds = %cond.true, %entry
  ret void

cond.true:                                        ; preds = %entry
  %1 = load i64, ptr %k.addr, align 8
  br label %common.ret
}
