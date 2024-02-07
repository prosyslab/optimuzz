target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @fmt_669_read_info(ptr %header, i8 %0) {
entry:
  %conv27 = zext i8 %0 to i32
  %cmp28 = icmp sgt i32 %conv27, 127
  br i1 %cmp28, label %if.then30, label %common.ret

common.ret:                                       ; preds = %if.then30, %entry
  ret i32 0

if.then30:                                        ; preds = %entry
  store i32 0, ptr %header, align 4
  br label %common.ret
}
