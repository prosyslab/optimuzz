target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @readSeparateTilesIntoBuffer(ptr %bps, i16 %0) {
entry:
  %bps1 = alloca i16, align 2
  br label %if.end

if.end:                                           ; preds = %entry
  br label %if.end12

if.end12:                                         ; preds = %if.end
  br label %if.end21

if.end21:                                         ; preds = %if.end12
  %1 = load i16, ptr %bps, align 2
  %conv22 = zext i16 %0 to i32
  %rem = srem i32 %conv22, 8
  %cmp23 = icmp ne i32 %rem, 0
  br i1 %cmp23, label %if.then25, label %if.end27

if.then25:                                        ; preds = %if.end21
  ret i32 0

if.end27:                                         ; preds = %if.end21
  ret i32 0
}
