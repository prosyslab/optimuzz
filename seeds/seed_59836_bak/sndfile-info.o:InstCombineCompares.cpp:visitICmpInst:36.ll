target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call141 = call i32 @instrument_dump(ptr null)
  ret i32 0
}

define internal i32 @instrument_dump(ptr %call) {
entry:
  %cmp = icmp eq ptr %call, null
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %0 = load ptr, ptr %call, align 8
  br label %common.ret
}
