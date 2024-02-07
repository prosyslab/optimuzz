target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sha256_process_bytes(ptr %buffer.addr, i64 %0) {
entry:
  %rem = urem i64 %0, 4
  %cmp27 = icmp ne i64 %rem, 0
  br i1 %cmp27, label %common.ret, label %if.else

common.ret:                                       ; preds = %if.else, %entry
  ret void

if.else:                                          ; preds = %entry
  %1 = load ptr, ptr %buffer.addr, align 8
  br label %common.ret
}
