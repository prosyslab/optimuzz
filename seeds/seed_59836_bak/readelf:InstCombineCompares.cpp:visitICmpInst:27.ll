target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @cplus_demangle_type(ptr %di.addr, i1 %cmp131) {
entry:
  br i1 %cmp131, label %cond.end138, label %cond.false134

cond.false134:                                    ; preds = %entry
  %0 = load i8, ptr %di.addr, align 1
  %conv137 = sext i8 %0 to i32
  br label %cond.end138

cond.end138:                                      ; preds = %cond.false134, %entry
  %cond139 = phi i32 [ %conv137, %cond.false134 ], [ 0, %entry ]
  %cmp140 = icmp ne i32 %cond139, 0
  br i1 %cmp140, label %if.then142, label %if.end143

if.then142:                                       ; preds = %cond.end138
  store ptr null, ptr %di.addr, align 8
  br label %if.end143

if.end143:                                        ; preds = %if.then142, %cond.end138
  ret ptr null
}
