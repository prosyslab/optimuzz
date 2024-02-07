target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yylex() {
entry:
  br label %while.cond21

while.cond21:                                     ; preds = %sw.bb107, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %while.cond21, %entry
  br label %while.cond21

sw.bb:                                            ; preds = %sw.bb
  switch i32 0, label %sw.default [
    i32 0, label %sw.bb
    i32 1, label %return
    i32 2, label %return
    i32 3, label %return
    i32 4, label %return
    i32 5, label %while.cond21
    i32 6, label %while.cond21
    i32 7, label %while.cond21
    i32 8, label %while.cond21
    i32 9, label %return
    i32 10, label %return
    i32 11, label %return
    i32 12, label %return
    i32 13, label %return
    i32 14, label %return
    i32 15, label %return
    i32 16, label %return
    i32 17, label %return
    i32 18, label %return
    i32 19, label %return
    i32 20, label %return
    i32 21, label %return
    i32 22, label %return
    i32 23, label %return
    i32 24, label %return
    i32 25, label %while.cond21
    i32 27, label %return
    i32 26, label %sw.bb107
  ]

sw.bb107:                                         ; preds = %sw.bb
  %call1301 = call i32 @yy_try_NUL_trans(i32 0)
  br label %while.cond21

sw.default:                                       ; preds = %sw.bb
  unreachable

return:                                           ; preds = %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb, %sw.bb
  ret i32 0
}

define internal i32 @yy_try_NUL_trans(i32 %0) {
entry:
  %tobool27.not = icmp eq i32 %0, 0
  %cond = select i1 %tobool27.not, i32 1, i32 0
  ret i32 %cond
}
