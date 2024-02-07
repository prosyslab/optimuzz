target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @WriteAiffHeader() {
entry:
  br label %return

if.then27:                                        ; No predecessors!
  call void @put_extended(ptr null, i32 0)
  br label %return

return:                                           ; preds = %if.then27, %entry
  ret i32 0
}

define internal void @put_extended(ptr %value.addr, i32 %0) {
entry:
  %call = call i32 @abs(i32 %0)
  %conv2 = sext i32 %call to i64
  store i64 %conv2, ptr %value.addr, align 8
  ret void
}

declare i32 @abs(i32)
