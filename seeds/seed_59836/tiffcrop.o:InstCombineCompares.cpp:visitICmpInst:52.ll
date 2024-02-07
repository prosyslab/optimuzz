target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  ret i32 0

if.end137:                                        ; No predecessors!
  %call1471 = call i32 @loadImage(ptr null, i32 0)
  unreachable
}

define internal i32 @loadImage(ptr %length, i32 %0) {
entry:
  %conv172 = zext i32 %0 to i64
  %conv179 = zext i32 %0 to i64
  %mul180 = mul i64 %conv172, %conv179
  %1 = load i64, ptr %length, align 8
  %cmp181 = icmp slt i64 %1, %mul180
  br i1 %cmp181, label %if.then183, label %if.end184

if.then183:                                       ; preds = %entry
  %2 = load i64, ptr %length, align 8
  br label %if.end184

if.end184:                                        ; preds = %if.then183, %entry
  ret i32 0
}
