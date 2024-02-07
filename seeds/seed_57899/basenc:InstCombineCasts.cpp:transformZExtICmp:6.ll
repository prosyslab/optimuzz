target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %base_decode_ctx) {
entry:
  store ptr @base16_decode_ctx, ptr %base_decode_ctx, align 8
  ret i32 0
}

define internal i1 @base16_decode_ctx() {
entry:
  %ctx.addr = alloca ptr, align 8
  %0 = load i8, ptr %ctx.addr, align 1
  %tobool41 = trunc i8 %0 to i1
  %lnot42 = xor i1 %tobool41, true
  %frombool = zext i1 %lnot42 to i8
  store i8 %frombool, ptr %ctx.addr, align 1
  ret i1 false
}
