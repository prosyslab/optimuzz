target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %outfilename) {
entry:
  %cmp152 = icmp eq ptr %outfilename, null
  br i1 %cmp152, label %if.then154, label %if.end157

if.then154:                                       ; preds = %entry
  %0 = load ptr, ptr %outfilename, align 8
  br label %if.end157

if.end157:                                        ; preds = %if.then154, %entry
  ret i32 0
}
