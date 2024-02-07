target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  ret i32 0

if.end137:                                        ; No predecessors!
  %call155 = call i32 @correct_orientation()
  unreachable
}

define internal i32 @correct_orientation() {
entry:
  br label %return

if.end:                                           ; No predecessors!
  %call = call i32 @mirrorImage()
  br label %return

return:                                           ; preds = %if.end, %entry
  ret i32 0
}

define internal i32 @mirrorImage() {
entry:
  %call441 = call i32 @reverseSamplesBytes(i16 0)
  ret i32 0
}

define internal i32 @reverseSamplesBytes(i16 %0) {
entry:
  %conv = zext i16 %0 to i32
  %conv2 = zext i16 %0 to i32
  %mul = mul i32 %conv, %conv2
  %cmp4 = icmp ugt i32 %mul, 0
  br i1 %cmp4, label %common.ret, label %sw.bb

common.ret:                                       ; preds = %sw.bb, %entry
  ret i32 0

sw.bb:                                            ; preds = %entry
  %mul13 = mul i32 0, 0
  br label %common.ret
}
