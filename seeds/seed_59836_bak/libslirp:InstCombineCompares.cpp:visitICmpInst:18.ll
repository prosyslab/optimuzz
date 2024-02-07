target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @arp_table_search(ptr %ip_addr.addr, i32 %0) {
entry:
  %cmp = icmp eq i32 %0, 0
  %or.cond = select i1 %cmp, i1 false, i1 true
  br i1 %or.cond, label %if.then12, label %lor.lhs.false10

lor.lhs.false10:                                  ; preds = %entry
  %1 = load i32, ptr %ip_addr.addr, align 4
  br label %if.then12

if.then12:                                        ; preds = %lor.lhs.false10, %entry
  ret i1 false
}
