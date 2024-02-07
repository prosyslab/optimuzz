target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @program_name(ptr %tmp, i1 %tobool) {
entry:
  %cond = select i1 %tobool, ptr %tmp, ptr null
  store ptr %cond, ptr %tmp, align 8
  %call1 = call ptr @strstr()
  %0 = load ptr, ptr %tmp, align 8
  %cmp = icmp eq ptr %call1, %0
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret ptr null

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %tmp, align 8
  br label %common.ret
}

; Function Attrs: memory(read)
declare ptr @strstr() #0

attributes #0 = { memory(read) }
