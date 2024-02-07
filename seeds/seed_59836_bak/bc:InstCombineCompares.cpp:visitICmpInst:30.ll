target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yylex(ptr %yy_c_buf_p, ptr %0, i64 %idxprom284) {
entry:
  %1 = load ptr, ptr %yy_c_buf_p, align 8
  %arrayidx285 = getelementptr i8, ptr %0, i64 %idxprom284
  %cmp286 = icmp ule ptr %1, %arrayidx285
  br i1 %cmp286, label %if.then288, label %common.ret

common.ret:                                       ; preds = %if.then288, %entry
  ret i32 0

if.then288:                                       ; preds = %entry
  %2 = load ptr, ptr %yy_c_buf_p, align 8
  br label %common.ret
}
