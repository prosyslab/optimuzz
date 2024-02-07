target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @rpl_mbrtoc32(ptr %0) {
entry:
  %cmp9 = icmp ne ptr %0, null
  br i1 %cmp9, label %if.then10, label %if.end11

if.then10:                                        ; preds = %entry
  %conv = zext i8 0 to i32
  br label %if.end11

if.end11:                                         ; preds = %if.then10, %entry
  ret i64 0
}
