target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @Ascii85EncodeBlock(ptr %raw_p.addr) {
entry:
  %tobool = icmp ne ptr %raw_p.addr, null
  br i1 %tobool, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i64 0

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %raw_p.addr, align 8
  br label %common.ret
}
