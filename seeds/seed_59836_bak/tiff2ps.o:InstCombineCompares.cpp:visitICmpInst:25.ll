target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @Ascii85EncodeBlock(ptr %raw_l.addr, i64 %0) {
entry:
  %dec = add nsw i64 %0, -1
  %cmp52 = icmp sgt i64 %dec, 0
  br i1 %cmp52, label %if.then54, label %if.end59

if.then54:                                        ; preds = %entry
  %1 = load ptr, ptr %raw_l.addr, align 8
  br label %if.end59

if.end59:                                         ; preds = %if.then54, %entry
  ret i64 0
}
