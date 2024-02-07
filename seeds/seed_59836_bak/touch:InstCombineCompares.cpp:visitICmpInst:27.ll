target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@yycheck = internal constant [115 x i8] c"\1B\05\06\07\08\09\0A\13\0C\17\04\0F\10g\1A\13\05\06\07\08\09\0A\1Aq\1C\13\13\14\15\16\13\05\06\07\08\09\0A\1A\14\00\16\1B\05\06\07\08\09\0A\0B\0C\0D\0E\1A\10\11\12\13\14\15\16\0F\18\19\19\13\1B\13\14\04\1Fa\1A\05\06\07\08\09\0A\13\0Cl\13\14\09\09\1Ar\05\06\07\08\09\0A\0F\19\13\03\13\13\1B\14\14U\14\14\14<\FF\14\14\13\FF\FF\1A\1C"

define i32 @yyparse(i64 %idxprom798) {
entry:
  %arrayidx799.phi.trans.insert = getelementptr [115 x i8], ptr @yycheck, i64 0, i64 %idxprom798
  %.pre = load i8, ptr %arrayidx799.phi.trans.insert, align 1
  br label %yysetstate

yysetstate:                                       ; preds = %yysetstate, %entry
  %conv800 = sext i8 %.pre to i32
  %cmp801 = icmp eq i32 %conv800, 0
  br i1 %cmp801, label %yysetstate, label %if.end811

if.end811:                                        ; preds = %yysetstate
  ret i32 0
}
