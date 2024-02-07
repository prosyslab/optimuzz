target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i64 @compute_bucket_size() {
entry:
  %call1 = call i64 @next_prime(ptr null)
  ret i64 0
}

define internal i64 @next_prime(ptr %candidate.addr) {
entry:
  %0 = load i64, ptr %candidate.addr, align 8
  %cmp = icmp ult i64 %0, 10
  %spec.store.select = select i1 %cmp, i64 10, i64 %0
  store i64 %spec.store.select, ptr %candidate.addr, align 8
  ret i64 0
}

define i1 @hash_rehash() {
entry:
  %call = call i64 @compute_bucket_size()
  ret i1 false
}
