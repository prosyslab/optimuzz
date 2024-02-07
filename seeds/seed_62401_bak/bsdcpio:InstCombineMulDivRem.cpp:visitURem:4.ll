target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @blake2sp_update(ptr %inlen.addr, i64 %0) {
entry:
  %rem26 = urem i64 %0, 512
  store i64 %rem26, ptr %inlen.addr, align 8
  ret i32 0
}
