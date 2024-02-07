target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @rpl_fts_read(ptr %instr, i16 %0) {
entry:
  %conv = zext i16 %0 to i32
  %cmp4 = icmp eq i32 %conv, 0
  br i1 %cmp4, label %if.then6, label %common.ret

common.ret:                                       ; preds = %if.then6, %entry
  ret ptr null

if.then6:                                         ; preds = %entry
  %1 = load ptr, ptr %instr, align 8
  br label %common.ret
}
