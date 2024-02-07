target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call221 = call i32 @readMovieHeader(ptr null, i8 0)
  ret i32 0
}

define internal i32 @readMovieHeader(ptr %first, i8 %0) {
entry:
  %conv6 = sext i8 %0 to i32
  %cmp7 = icmp eq i32 %conv6, 0
  br i1 %cmp7, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret i32 0

land.lhs.true:                                    ; preds = %entry
  %1 = load ptr, ptr %first, align 8
  br label %common.ret
}
