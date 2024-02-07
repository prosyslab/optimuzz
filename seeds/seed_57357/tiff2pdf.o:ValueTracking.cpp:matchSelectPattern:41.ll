target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @t2p_read_tiff_data(ptr %r, i1 %cmp205, i1 %cmp207) {
entry:
  %or.cond1 = select i1 %cmp207, i1 false, i1 %cmp205
  br i1 %or.cond1, label %if.then212, label %if.end214

if.then212:                                       ; preds = %entry
  %0 = load ptr, ptr %r, align 8
  br label %if.end214

if.end214:                                        ; preds = %if.then212, %entry
  ret void
}
