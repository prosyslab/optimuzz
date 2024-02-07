target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @rpl_re_compile_fastmap() {
entry:
  call void @re_compile_fastmap_iter(i32 0)
  ret i32 0
}

define internal void @re_compile_fastmap_iter(i32 %bf.load33) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %bf.lshr = lshr i32 %bf.load33, 1
  %tobool35 = icmp ne i32 %bf.lshr, 0
  br i1 %tobool35, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  ret void
}
