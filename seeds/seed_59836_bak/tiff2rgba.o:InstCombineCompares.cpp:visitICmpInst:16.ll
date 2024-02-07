target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb2

sw.bb2:                                           ; preds = %sw.bb2, %entry
  br label %sw.bb2

do.body:                                          ; preds = %do.body
  %call53 = call i32 @tiffcvt()
  br label %do.body
}

define internal i32 @tiffcvt() {
entry:
  br label %return

if.else69:                                        ; No predecessors!
  %call701 = call i32 @cvt_whole_image(i64 0)
  br label %return

return:                                           ; preds = %if.else69, %entry
  ret i32 0
}

define internal i32 @cvt_whole_image(i64 %0) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %cmp31 = icmp ugt i64 %0, 0
  br i1 %cmp31, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret i32 0
}
