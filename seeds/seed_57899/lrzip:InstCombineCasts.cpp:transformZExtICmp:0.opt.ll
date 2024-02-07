; ModuleID = 'seeds/seed_57899/lrzip:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/lrzip:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @_ZN7libzpaq10StateTable8discountERi(ptr %n0.addr, i32 %0) {
entry:
  %cmp13 = icmp sgt i32 %0, 0
  %conv14 = zext i1 %cmp13 to i32
  store i32 %conv14, ptr %n0.addr, align 4
  ret void
}
