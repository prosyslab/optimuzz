target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_write_chunk_data(ptr %png_ptr.addr, i1 %cmp, i1 %cmp1) {
entry:
  %or.cond1 = select i1 %cmp1, i1 %cmp, i1 false
  br i1 %or.cond1, label %if.then3, label %if.end4

if.then3:                                         ; preds = %entry
  %0 = load ptr, ptr %png_ptr.addr, align 8
  br label %if.end4

if.end4:                                          ; preds = %if.then3, %entry
  ret void
}
