target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yyparse(ptr %yyss1) {
entry:
  %yyssa = alloca [200 x i8], align 16
  %0 = load ptr, ptr %yyss1, align 8
  %cmp28 = icmp ne ptr %0, %yyssa
  br i1 %cmp28, label %if.then30, label %if.end31

if.then30:                                        ; preds = %entry
  %1 = load ptr, ptr %yyss1, align 8
  br label %if.end31

if.end31:                                         ; preds = %if.then30, %entry
  ret i32 0
}
