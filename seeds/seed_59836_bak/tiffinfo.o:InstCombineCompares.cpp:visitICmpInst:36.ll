target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @TIFFReadSeparateStripData(ptr %buf) {
entry:
  %tobool.not = icmp eq ptr %buf, null
  br i1 %tobool.not, label %common.ret, label %if.then5

common.ret:                                       ; preds = %if.then5, %entry
  ret void

if.then5:                                         ; preds = %entry
  store i32 0, ptr %buf, align 4
  br label %common.ret
}
