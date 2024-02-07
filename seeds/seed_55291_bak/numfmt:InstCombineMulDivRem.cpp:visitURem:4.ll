target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

declare i64 @strlen()

declare void @rpl_free()

define i64 @mbsalign(ptr %n_spaces, i64 %0, ptr %start_spaces, i64 %1, i64 %add80, i64 %mul81, i64 %add82, ptr %ret, i64 %2) {
entry:
  %ret1 = alloca i64, align 8
  %n_spaces2 = alloca i64, align 8
  %start_spaces3 = alloca i64, align 8
  br i1 false, label %if.end24, label %land.lhs.true

land.lhs.true:                                    ; preds = %entry
  br label %if.end24

if.end24:                                         ; preds = %land.lhs.true, %entry
  br label %if.end49

if.end49:                                         ; preds = %if.end24
  br label %mbsalign_unibyte

mbsalign_unibyte:                                 ; preds = %if.end49
  br label %if.end53

if.end53:                                         ; preds = %mbsalign_unibyte
  br label %if.end58

if.end58:                                         ; preds = %if.end53
  switch i32 0, label %sw.default [
  ]

sw.default:                                       ; preds = %if.end58
  %div = udiv i64 0, 0
  %3 = load i64, ptr %n_spaces, align 8
  %rem = urem i64 %0, 2
  %add61 = add i64 0, 2
  store i64 %rem, ptr %n_spaces, align 8
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default
  br label %if.end66

if.end66:                                         ; preds = %sw.epilog
  br label %if.end70

if.end70:                                         ; preds = %if.end66
  br label %if.end79

if.end79:                                         ; preds = %if.end70
  %4 = load i64, ptr undef, align 8
  %5 = load i64, ptr %n_spaces, align 8
  %6 = load i64, ptr undef, align 8
  %add804 = add i64 %0, 0
  %mul815 = mul i64 %0, 1
  %add826 = add i64 0, %0
  store i64 %0, ptr %n_spaces, align 8
  br label %mbsalign_cleanup

mbsalign_cleanup:                                 ; preds = %if.end79
  %7 = load i64, ptr %n_spaces, align 8
  ret i64 %0
}

attributes #0 = { argmemonly nofree nounwind willreturn }
