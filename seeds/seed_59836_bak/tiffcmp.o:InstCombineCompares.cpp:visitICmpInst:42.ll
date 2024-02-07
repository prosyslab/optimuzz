target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb3

sw.bb3:                                           ; preds = %sw.bb3, %entry
  br label %sw.bb3

if.end16:                                         ; No predecessors!
  br label %while.cond17

while.cond17:                                     ; preds = %while.cond17, %if.end16
  %call181 = call i32 @tiffcmp(ptr null, i16 0)
  br label %while.cond17
}

define internal i32 @tiffcmp(ptr %config2, i16 %0) {
entry:
  %conv28 = zext i16 %0 to i32
  %cmp29 = icmp ne i32 0, %conv28
  br i1 %cmp29, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret i32 0

land.lhs.true:                                    ; preds = %entry
  %1 = load i16, ptr %config2, align 2
  br label %common.ret
}
