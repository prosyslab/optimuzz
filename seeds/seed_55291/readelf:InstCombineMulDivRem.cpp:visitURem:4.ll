target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal ptr @unw_decode_p2_p5(ptr %insn, i64 %0) {
entry:
  %insn1 = alloca i64, align 8
  br label %if.else

if.else:                                          ; preds = %entry
  br label %if.else74

if.else74:                                        ; preds = %if.else
  br label %if.then78

if.then78:                                        ; preds = %if.else74
  br label %do.body79

do.body79:                                        ; preds = %if.then78
  br label %if.end89

if.end89:                                         ; preds = %do.body79
  br label %for.cond

for.cond:                                         ; preds = %if.end89
  br label %for.body

for.body:                                         ; preds = %for.cond
  %1 = load i64, ptr %insn, align 8
  %rem = urem i64 %0, 4
  %cmp93 = icmp eq i64 %rem, 0
  br i1 %cmp93, label %if.then95, label %if.end97

if.then95:                                        ; preds = %for.body
  br label %if.end97

if.end97:                                         ; preds = %if.then95, %for.body
  ret ptr null
}
