target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @build_cmdline() {
entry:
  %call1 = call i32 @cmdline_length(i32 0)
  ret void
}

define internal i32 @cmdline_length(i32 %0) {
entry:
  br label %for.cond2

for.cond2:                                        ; preds = %for.cond2, %entry
  %cmp17 = icmp ugt i32 %0, 0
  br i1 %cmp17, label %land.lhs.true, label %for.cond2

land.lhs.true:                                    ; preds = %for.cond2
  ret i32 0
}
