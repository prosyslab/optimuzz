target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ftp_epsv(ptr %delim, i8 %0) {
entry:
  %conv34 = sext i8 %0 to i32
  %cmp35 = icmp sgt i32 %conv34, 126
  br i1 %cmp35, label %common.ret, label %if.end40

common.ret:                                       ; preds = %if.end40, %entry
  ret i32 0

if.end40:                                         ; preds = %entry
  store i32 0, ptr %delim, align 4
  br label %common.ret
}
