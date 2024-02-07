target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @t2p_write_pdf_xobject_icccs(ptr %t2p.addr) {
entry:
  %cmp6 = icmp ne ptr %t2p.addr, null
  br i1 %cmp6, label %if.then7, label %if.end8

if.then7:                                         ; preds = %entry
  %0 = load ptr, ptr %t2p.addr, align 8
  br label %if.end8

if.end8:                                          ; preds = %if.then7, %entry
  ret i64 0
}
