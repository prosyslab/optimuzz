; ModuleID = 'seeds/seed_57899/latex2rtf:InstCombineCasts.cpp:transformZExtICmp:4.ll'
source_filename = "seeds/seed_57899/latex2rtf:InstCombineCasts.cpp:transformZExtICmp:4.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @even(i64 %0) {
entry:
  %1 = trunc i64 %0 to i32
  %2 = and i32 %1, 1
  ret i32 %2
}
