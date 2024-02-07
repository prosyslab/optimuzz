target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @archive_entry_sparse_add_entry(i64 noundef %length, ptr %offset.addr, i64 %0) {
entry:
  %cmp = icmp slt i64 %0, 0
  %cmp2 = icmp slt i64 %length, 0
  %or.cond = select i1 %cmp, i1 true, i1 %cmp2
  br i1 %or.cond, label %common.ret, label %if.end

common.ret:                                       ; preds = %if.end, %entry
  ret void

if.end:                                           ; preds = %entry
  %1 = load i64, ptr %offset.addr, align 8
  br label %common.ret
}
