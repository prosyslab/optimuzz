target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @archive_string_ensure(ptr %as.addr) {
entry:
  %tobool = icmp ne ptr %as.addr, null
  br i1 %tobool, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret ptr null

land.lhs.true:                                    ; preds = %entry
  %0 = load i64, ptr %as.addr, align 8
  br label %common.ret
}
