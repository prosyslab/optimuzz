target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb5

sw.bb5:                                           ; preds = %sw.bb5, %entry
  br label %sw.bb5

if.end140:                                        ; No predecessors!
  %call1481 = call i1 @cat(ptr null, i32 0)
  br label %contin

contin:                                           ; preds = %contin, %if.end140
  br label %contin
}

define internal i1 @cat(ptr %newlines, i32 %0) {
entry:
  %inc = add nsw i32 %0, 1
  %cmp55 = icmp sgt i32 %inc, 0
  br i1 %cmp55, label %if.then56, label %common.ret

common.ret:                                       ; preds = %if.then56, %entry
  ret i1 false

if.then56:                                        ; preds = %entry
  %1 = load i32, ptr %newlines, align 4
  br label %common.ret
}
