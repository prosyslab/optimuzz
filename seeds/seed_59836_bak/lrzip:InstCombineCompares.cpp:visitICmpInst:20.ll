target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @aes_crypt_cbc(ptr %length.addr, i64 %0) {
entry:
  %rem = srem i64 %0, 16
  %tobool = icmp ne i64 %rem, 0
  br i1 %tobool, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  store i32 0, ptr %length.addr, align 4
  br label %common.ret
}
