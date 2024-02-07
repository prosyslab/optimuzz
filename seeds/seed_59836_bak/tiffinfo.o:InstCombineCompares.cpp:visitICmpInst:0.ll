target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @TIFFReadContigTileData(ptr %th, i64 %0) {
entry:
  %cmp11 = icmp ugt i64 1, %0
  br i1 %cmp11, label %if.then13, label %common.ret

common.ret:                                       ; preds = %if.then13, %entry
  ret void

if.then13:                                        ; preds = %entry
  %1 = load ptr, ptr %th, align 8
  br label %common.ret
}
