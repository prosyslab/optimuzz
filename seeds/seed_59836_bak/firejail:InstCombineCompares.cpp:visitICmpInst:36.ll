target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @fprintf(...)

define void @caps_check_list(ptr %clist.addr) {
entry:
  %cmp = icmp eq ptr %clist.addr, null
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %0 = load ptr, ptr %clist.addr, align 8
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  %call = call i32 (...) @fprintf()
  unreachable
}
