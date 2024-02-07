target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %wc, i16 %0) {
entry:
  %conv164 = sext i16 %0 to i32
  %cmp165 = icmp sgt i32 %conv164, 0
  br i1 %cmp165, label %if.then171, label %lor.lhs.false167

lor.lhs.false167:                                 ; preds = %entry
  %1 = load ptr, ptr %wc, align 8
  br label %if.then171

if.then171:                                       ; preds = %lor.lhs.false167, %entry
  ret i32 0
}
