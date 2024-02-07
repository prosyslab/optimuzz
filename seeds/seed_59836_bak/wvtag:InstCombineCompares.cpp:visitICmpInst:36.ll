target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @DoCloseHandle(ptr %hFile.addr) {
entry:
  %tobool = icmp ne ptr %hFile.addr, null
  br i1 %tobool, label %cond.true, label %common.ret

common.ret:                                       ; preds = %cond.true, %entry
  ret i32 0

cond.true:                                        ; preds = %entry
  %0 = load ptr, ptr %hFile.addr, align 8
  br label %common.ret
}
