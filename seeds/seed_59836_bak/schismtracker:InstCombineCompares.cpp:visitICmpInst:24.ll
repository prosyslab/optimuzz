target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @handle_key() {
entry:
  %call1 = call i32 @_handle_ime(i32 0)
  ret void
}

define internal i32 @_handle_ime(i32 %0) {
entry:
  %inc = add nsw i32 %0, 1
  %cmp32 = icmp sge i32 %inc, 0
  br i1 %cmp32, label %if.then33, label %if.end

if.then33:                                        ; preds = %entry
  call void (...) @status_text_flash_bios()
  br label %if.end

if.end:                                           ; preds = %if.then33, %entry
  ret i32 0
}

declare void @status_text_flash_bios(...)
