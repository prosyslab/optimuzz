target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @printTIF(i1 %tobool, ptr %compression, i1 %cmp) {
entry:
  %brmerge = select i1 %tobool, i1 false, i1 %cmp
  br i1 %brmerge, label %return, label %if.end

if.end:                                           ; preds = %entry
  %0 = load ptr, ptr %compression, align 8
  br label %return

return:                                           ; preds = %if.end, %entry
  ret void
}
