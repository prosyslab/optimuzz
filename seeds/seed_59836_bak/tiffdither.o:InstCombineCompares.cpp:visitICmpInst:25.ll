target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb24

sw.bb24:                                          ; preds = %sw.bb24, %entry
  br label %sw.bb24

if.then56:                                        ; No predecessors!
  %call1261 = call i32 @fsdither(ptr null, i32 0)
  ret i32 0
}

define internal i32 @fsdither(ptr %bit, i32 %0) {
entry:
  br label %for.cond59

for.cond59:                                       ; preds = %if.then84, %for.cond59, %entry
  %shr = ashr i32 %0, 1
  %cmp82 = icmp eq i32 %shr, 0
  br i1 %cmp82, label %if.then84, label %for.cond59

if.then84:                                        ; preds = %for.cond59
  %1 = load ptr, ptr %bit, align 8
  br label %for.cond59
}
