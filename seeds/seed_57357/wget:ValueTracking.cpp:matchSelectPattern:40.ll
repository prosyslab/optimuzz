target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @connect_to_ip(ptr %call4) {
entry:
  %cmp5 = icmp ne ptr %call4, null
  br i1 %cmp5, label %if.then6, label %if.end

if.then6:                                         ; preds = %entry
  %0 = load ptr, ptr %call4, align 8
  br label %if.end

if.end:                                           ; preds = %if.then6, %entry
  ret i32 0
}
