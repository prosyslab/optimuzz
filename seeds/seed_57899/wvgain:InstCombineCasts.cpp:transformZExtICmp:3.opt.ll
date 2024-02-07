; ModuleID = 'seeds/seed_57899/wvgain:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/wvgain:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @DoReadFile(i32 %call3) {
entry:
  %tobool4.not = icmp eq i32 %call3, 0
  %lnot.ext = zext i1 %tobool4.not to i32
  ret i32 %lnot.ext
}
