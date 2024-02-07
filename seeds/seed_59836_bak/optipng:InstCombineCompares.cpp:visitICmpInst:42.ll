target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @_tr_flush_block() {
entry:
  %call1 = call i32 @detect_data_type(ptr null, i16 0)
  ret void
}

define internal i32 @detect_data_type(ptr %s.addr, i16 %0) {
entry:
  %conv = zext i16 %0 to i32
  %cmp1 = icmp ne i32 %conv, 0
  br i1 %cmp1, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  store i32 0, ptr %s.addr, align 4
  br label %common.ret
}
