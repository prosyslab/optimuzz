target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call) {
entry:
  %cmp = icmp eq i32 %call, 0
  br i1 %cmp, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret i32 0

land.lhs.true:                                    ; preds = %entry
  %call12 = call i32 @getuid()
  br label %common.ret
}

declare i32 @getuid()
