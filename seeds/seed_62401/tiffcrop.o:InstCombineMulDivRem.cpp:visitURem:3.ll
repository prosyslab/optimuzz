target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  ret i32 0

if.end204:                                        ; No predecessors!
  %call2051 = call i32 @writeCroppedImage(ptr null, i16 0)
  unreachable
}

define internal i32 @writeCroppedImage(ptr %bps, i16 %0) {
entry:
  %conv184 = zext i16 %0 to i32
  %rem = srem i32 %conv184, 8
  %cmp185 = icmp eq i32 %rem, 0
  br i1 %cmp185, label %if.then192, label %lor.lhs.false187

lor.lhs.false187:                                 ; preds = %entry
  %1 = load i16, ptr %bps, align 2
  br label %if.then192

if.then192:                                       ; preds = %lor.lhs.false187, %entry
  ret i32 0
}
