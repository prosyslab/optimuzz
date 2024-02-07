; ModuleID = 'seeds/seed_57899/sum:InstCombineCasts.cpp:transformZExtICmp:5.ll'
source_filename = "seeds/seed_57899/sum:InstCombineCasts.cpp:transformZExtICmp:5.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @human_readable(ptr %opts.addr, i32 %0) {
entry:
  %1 = and i32 %0, 32
  %cmp75.not.not = icmp eq i32 %1, 0
  br i1 %cmp75.not.not, label %if.then83, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  br label %if.then83

if.then83:                                        ; preds = %lor.lhs.false, %entry
  ret ptr null
}
