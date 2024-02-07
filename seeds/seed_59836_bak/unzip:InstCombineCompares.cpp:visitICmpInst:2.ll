target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @get_crc_table() {
entry:
  call void @make_crc_table(i32 0)
  ret ptr null
}

define internal void @make_crc_table(i32 %0) {
entry:
  br label %for.cond2

for.cond2:                                        ; preds = %for.cond2, %entry
  %tobool.not = icmp eq i32 %0, 0
  br i1 %tobool.not, label %for.end, label %for.cond2

for.end:                                          ; preds = %for.cond2
  ret void
}
