target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @extract_izvms_block() {
entry:
  br label %return

if.then20:                                        ; No predecessors!
  switch i32 0, label %return [
    i32 0, label %return
    i32 1, label %sw.bb25
    i32 2, label %return
  ]

sw.bb25:                                          ; preds = %if.then20
  call void @decompress_bits(ptr null, i32 0)
  br label %return

return:                                           ; preds = %sw.bb25, %if.then20, %if.then20, %if.then20, %entry
  ret ptr null
}

define internal void @decompress_bits(ptr %bitbuf, i32 %0) {
entry:
  %sub = sub nsw i32 %0, 1
  %cmp4 = icmp slt i32 %sub, 0
  br i1 %cmp4, label %if.then6, label %common.ret

if.then6:                                         ; preds = %entry
  %1 = load ptr, ptr %bitbuf, align 8
  br label %common.ret

common.ret:                                       ; preds = %if.then6, %entry
  ret void
}
