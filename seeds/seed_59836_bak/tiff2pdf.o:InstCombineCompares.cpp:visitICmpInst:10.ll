target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @t2p_compose_pdf_page(ptr %t2p.addr, i32 %0) {
entry:
  %istiled = alloca i32, align 4
  %cmp140 = icmp eq i32 %0, 0
  %cond = select i1 %cmp140, i32 0, i32 1
  store i32 %cond, ptr %istiled, align 4
  %1 = load i32, ptr %istiled, align 4
  %cmp142 = icmp eq i32 %1, 0
  br i1 %cmp142, label %if.then144, label %common.ret

common.ret:                                       ; preds = %if.then144, %entry
  ret void

if.then144:                                       ; preds = %entry
  %2 = load ptr, ptr %t2p.addr, align 8
  br label %common.ret
}
