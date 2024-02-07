target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @t2p_sample_lab_signed_to_unsigned(ptr %buffer.addr, i8 %0) {
entry:
  %conv = zext i8 %0 to i32
  %and = and i32 %conv, 128
  %cmp1 = icmp ne i32 %and, 0
  br i1 %cmp1, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i64 0

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %buffer.addr, align 8
  br label %common.ret
}
