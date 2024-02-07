target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sha256_process_bytes(ptr %len.addr, i64 %0) {
entry:
  %cmp25 = icmp uge i64 %0, 1
  br i1 %cmp25, label %if.then26, label %common.ret

common.ret:                                       ; preds = %if.then26, %entry
  ret void

if.then26:                                        ; preds = %entry
  %1 = load ptr, ptr %len.addr, align 8
  br label %common.ret
}
