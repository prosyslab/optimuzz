target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(ptr %outfilename) {
entry:
  %cmp24 = icmp ne ptr %outfilename, null
  br i1 %cmp24, label %if.then26, label %common.ret

common.ret:                                       ; preds = %if.then26, %entry
  ret i32 0

if.then26:                                        ; preds = %entry
  %0 = load ptr, ptr %outfilename, align 8
  br label %common.ret
}
