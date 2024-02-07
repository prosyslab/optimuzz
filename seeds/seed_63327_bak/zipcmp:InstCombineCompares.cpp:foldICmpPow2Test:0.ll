target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @diff_output_file(ptr %output.addr, i32 %0) {
entry:
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %if.end, label %common.ret

common.ret:                                       ; preds = %if.end, %entry
  ret void

if.end:                                           ; preds = %entry
  %1 = load ptr, ptr %output.addr, align 8
  br label %common.ret
}
