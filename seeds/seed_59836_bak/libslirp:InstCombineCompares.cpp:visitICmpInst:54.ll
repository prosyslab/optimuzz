target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sotranslate_accept(ptr %so.addr, i64 %0) {
entry:
  %and = and i64 1, %0
  %and9 = and i64 1, %0
  %cmp10 = icmp eq i64 %and, %and9
  br i1 %cmp10, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %so.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}
