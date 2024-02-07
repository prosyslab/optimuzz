target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @WriteAiffHeader(ptr %bcount, i32 %0) {
entry:
  %conv84 = zext i32 %0 to i64
  %cmp85 = icmp ne i64 %conv84, 0
  br i1 %cmp85, label %if.then132, label %lor.lhs.false87

lor.lhs.false87:                                  ; preds = %entry
  %1 = load i32, ptr %bcount, align 4
  br label %if.then132

if.then132:                                       ; preds = %lor.lhs.false87, %entry
  ret i32 0
}
