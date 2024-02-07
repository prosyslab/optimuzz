target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @sotranslate_in() {
entry:
  %call1 = call i1 @in6_equal_net.294(ptr null, i32 0)
  ret void
}

define internal i1 @in6_equal_net.294(ptr %prefix_len.addr, i32 %0) {
entry:
  %rem = srem i32 %0, 8
  %cmp2 = icmp eq i32 %rem, 0
  br i1 %cmp2, label %if.then4, label %common.ret

common.ret:                                       ; preds = %if.then4, %entry
  ret i1 false

if.then4:                                         ; preds = %entry
  store i1 false, ptr %prefix_len.addr, align 1
  br label %common.ret
}
