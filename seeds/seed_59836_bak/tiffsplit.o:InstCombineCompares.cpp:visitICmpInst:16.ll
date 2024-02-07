target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb6

sw.bb6:                                           ; preds = %sw.bb6, %entry
  br label %sw.bb6

if.then29:                                        ; No predecessors!
  br label %do.body

do.body:                                          ; preds = %do.body, %if.then29
  %call551 = call i32 @tiffcp(ptr null, i32 0)
  br label %do.body
}

define internal i32 @tiffcp(ptr %count, i32 %0) {
entry:
  %cmp44 = icmp ugt i32 %0, 0
  br i1 %cmp44, label %land.lhs.true46, label %common.ret

common.ret:                                       ; preds = %land.lhs.true46, %entry
  ret i32 0

land.lhs.true46:                                  ; preds = %entry
  %1 = load ptr, ptr %count, align 8
  br label %common.ret
}
