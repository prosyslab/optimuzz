target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @MD5_Update(ptr %size.addr, i64 %0) {
entry:
  %cmp20 = icmp uge i64 %0, 1
  br i1 %cmp20, label %if.then22, label %if.end26

if.then22:                                        ; preds = %entry
  %1 = load ptr, ptr %size.addr, align 8
  br label %if.end26

if.end26:                                         ; preds = %if.then22, %entry
  ret void
}
