target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @get_crc_table(ptr %0) {
entry:
  %cmp = icmp eq ptr %0, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @make_crc_table()
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret ptr null
}

declare void @make_crc_table()
