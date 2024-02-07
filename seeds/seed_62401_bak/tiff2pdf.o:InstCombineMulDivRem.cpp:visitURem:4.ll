target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @t2p_write_pdf_pages(ptr %i, i32 %0) {
entry:
  %rem = urem i32 %0, 8
  %cmp17 = icmp eq i32 %rem, 0
  br i1 %cmp17, label %if.then19, label %if.end22

if.then19:                                        ; preds = %entry
  %1 = load i64, ptr %i, align 8
  br label %if.end22

if.end22:                                         ; preds = %if.then19, %entry
  ret i64 0
}
