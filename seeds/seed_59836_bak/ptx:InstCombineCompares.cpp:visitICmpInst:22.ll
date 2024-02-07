target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @mmalloca(ptr %n.addr, { i65, i1 } %0, i1 %1) {
entry:
  %2 = extractvalue { i65, i1 } %0, 0
  %3 = trunc i65 %2 to i64
  %4 = sext i64 %3 to i65
  %5 = icmp ne i65 %2, %4
  %6 = or i1 %1, %5
  br i1 %6, label %if.end7, label %land.lhs.true

land.lhs.true:                                    ; preds = %entry
  %7 = load i64, ptr %n.addr, align 8
  br label %if.end7

if.end7:                                          ; preds = %land.lhs.true, %entry
  ret ptr null
}
