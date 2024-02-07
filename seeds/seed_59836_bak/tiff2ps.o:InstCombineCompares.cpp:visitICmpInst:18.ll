target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @Ascii85Flush(ptr %res, i8 %0) {
entry:
  %cmp2 = icmp eq i8 %0, 0
  %cond = select i1 %cmp2, ptr null, ptr %res
  %call5 = load volatile i64, ptr %cond, align 8
  ret void
}
