target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @abs(i32)

define i32 @csf_fx_do_freq_slide(ptr %slide.addr, i32 %0) {
entry:
  %call = call i32 @abs(i32 %0)
  store i32 %call, ptr %slide.addr, align 4
  ret i32 0
}
