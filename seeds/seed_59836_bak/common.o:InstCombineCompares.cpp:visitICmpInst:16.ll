target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sfe_apply_metadata_changes(ptr %sfinfo, i32 %0) {
entry:
  %infileminor = alloca i32, align 4
  %and27 = and i32 65535, %0
  store i32 %and27, ptr %infileminor, align 4
  %1 = load i32, ptr %infileminor, align 4
  %cmp28 = icmp eq i32 %1, 7
  %2 = load i32, ptr %infileminor, align 4
  %cmp29 = icmp eq i32 %2, 6
  %or.cond = select i1 %cmp28, i1 true, i1 %cmp29
  br i1 %or.cond, label %if.then30, label %common.ret

common.ret:                                       ; preds = %if.then30, %entry
  ret void

if.then30:                                        ; preds = %entry
  %3 = load ptr, ptr %sfinfo, align 8
  br label %common.ret
}
