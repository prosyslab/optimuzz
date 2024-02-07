target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @t2p_compose_pdf_page(ptr %tilewidth, i32 %0) {
entry:
  %cmp156 = icmp ugt i32 %0, 2147483647
  br i1 %cmp156, label %if.then170, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %1 = load i32, ptr %tilewidth, align 4
  br label %if.then170

if.then170:                                       ; preds = %lor.lhs.false, %entry
  ret void
}
