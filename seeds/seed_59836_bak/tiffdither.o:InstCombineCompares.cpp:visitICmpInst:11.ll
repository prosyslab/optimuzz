target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb

sw.bb:                                            ; preds = %sw.bb, %entry
  br label %sw.bb

if.then56:                                        ; No predecessors!
  %call1261 = call i32 @fsdither(i32 0, ptr null)
  ret i32 0
}

define internal i32 @fsdither(i32 %call29, ptr %inputline) {
entry:
  %cmp30 = icmp sle i32 %call29, 0
  br i1 %cmp30, label %common.ret, label %if.end33

common.ret:                                       ; preds = %if.end33, %entry
  ret i32 0

if.end33:                                         ; preds = %entry
  %0 = load ptr, ptr %inputline, align 8
  br label %common.ret
}
