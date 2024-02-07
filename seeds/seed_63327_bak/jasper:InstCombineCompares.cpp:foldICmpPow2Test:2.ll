target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @get_default_max_mem_usage(ptr %total_mem_size, i64 %0) {
entry:
  %tobool = icmp ne i64 %0, 0
  br i1 %tobool, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i64 0

if.then:                                          ; preds = %entry
  %1 = load i64, ptr %total_mem_size, align 8
  br label %common.ret
}
