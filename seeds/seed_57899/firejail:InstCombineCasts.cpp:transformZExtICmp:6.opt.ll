; ModuleID = 'seeds/seed_57899/firejail:InstCombineCasts.cpp:transformZExtICmp:6.ll'
source_filename = "seeds/seed_57899/firejail:InstCombineCasts.cpp:transformZExtICmp:6.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @x11_start_xvfb(ptr %dquote, i8 %0) {
entry:
  %1 = and i8 %0, 1
  %2 = xor i8 %1, 1
  store i8 %2, ptr %dquote, align 1
  ret void
}
