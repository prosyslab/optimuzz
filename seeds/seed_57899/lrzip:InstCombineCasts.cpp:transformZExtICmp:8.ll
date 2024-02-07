target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @LzmaDec_DecodeToDic(ptr %p.addr, i32 %0) {
entry:
  %cmp146 = icmp ne i32 %0, 0
  %cond = zext i1 %cmp146 to i32
  store i32 %cond, ptr %p.addr, align 4
  ret i32 0
}
