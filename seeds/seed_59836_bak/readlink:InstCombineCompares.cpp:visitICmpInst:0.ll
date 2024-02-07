target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i64 @compute_bucket_size(ptr %candidate.addr, i64 %0) {
entry:
  %cmp5 = icmp ult i64 0, %0
  br i1 %cmp5, label %common.ret, label %if.end8

common.ret:                                       ; preds = %if.end8, %entry
  ret i64 0

if.end8:                                          ; preds = %entry
  %1 = load i64, ptr %candidate.addr, align 8
  br label %common.ret
}

define i1 @hash_rehash() {
entry:
  %call1 = call i64 @compute_bucket_size(ptr null, i64 0)
  ret i1 false
}
