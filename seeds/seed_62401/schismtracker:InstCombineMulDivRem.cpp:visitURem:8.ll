target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @handle_key() {
entry:
  br label %if.end244

if.end10:                                         ; No predecessors!
  %call121 = call i32 @handle_key_global(ptr null, i32 0)
  br label %if.end244

if.end244:                                        ; preds = %if.end10, %entry
  ret void
}

define internal i32 @handle_key_global(ptr %0, i32 %1) {
entry:
  %inc = add i32 %1, 1
  %rem = urem i32 %inc, 6
  store i32 %rem, ptr %0, align 8
  ret i32 0
}
