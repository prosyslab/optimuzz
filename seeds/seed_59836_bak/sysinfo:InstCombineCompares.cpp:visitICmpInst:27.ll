target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@yypact = internal constant [55 x i8] c"\F2\08\04\F2\02\F2\04\03\F2\F2\06\00\07\06\06\06\09\0A\0B\0F\F2\F2\F2\F2\F2\F2\10\0E\06\06\F2\F2\05\11\12\13\14\F2\F2\F2\16\17\F2\18\1B\F2\F2\1C\01\F2\19\F2\1D\1E\F2"

define i32 @yyparse(ptr %yystate, i64 %idxprom) {
entry:
  %arrayidx = getelementptr [55 x i8], ptr @yypact, i64 0, i64 %idxprom
  %0 = load i8, ptr %arrayidx, align 1
  %conv47 = sext i8 %0 to i32
  %cmp48 = icmp eq i32 %conv47, 0
  br i1 %cmp48, label %common.ret, label %if.end51

common.ret:                                       ; preds = %if.end51, %entry
  ret i32 0

if.end51:                                         ; preds = %entry
  %1 = load i32, ptr %yystate, align 4
  br label %common.ret
}
