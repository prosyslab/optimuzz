; ModuleID = 'seeds/seed_57899/tiff2ps.o:InstCombineCasts.cpp:transformZExtICmp:8.ll'
source_filename = "seeds/seed_57899/tiff2ps.o:InstCombineCasts.cpp:transformZExtICmp:8.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %call10, ptr %interpolate) {
entry:
  %tobool.not = icmp ne i32 %call10, 0
  %cond = zext i1 %tobool.not to i32
  store i32 %cond, ptr %interpolate, align 4
  ret i32 0
}
