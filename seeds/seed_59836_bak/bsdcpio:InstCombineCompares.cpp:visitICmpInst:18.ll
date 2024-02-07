target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @archive_entry_copy_mac_metadata(ptr %p.addr) {
entry:
  %cmp = icmp eq ptr %p.addr, null
  %or.cond = select i1 %cmp, i1 false, i1 true
  br i1 %or.cond, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret void

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %p.addr, align 8
  br label %common.ret
}
