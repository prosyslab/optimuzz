target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @g_log(...)

define i1 @arp_table_search(i32 %0) {
entry:
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void (...) @g_log()
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i1 false
}
