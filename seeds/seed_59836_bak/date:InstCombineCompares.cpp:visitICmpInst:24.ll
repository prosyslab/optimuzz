target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yyparse(ptr %yyvsp, { i64, i1 } %0) {
entry:
  %1 = extractvalue { i64, i1 } %0, 0
  %2 = trunc i64 %1 to i32
  %3 = sext i32 %2 to i64
  %4 = icmp ne i64 %1, %3
  br i1 %4, label %common.ret, label %sw.epilog

common.ret:                                       ; preds = %sw.epilog, %entry
  ret i32 0

sw.epilog:                                        ; preds = %entry
  %5 = load i32, ptr %yyvsp, align 4
  br label %common.ret
}
