; ModuleID = 'seeds/seed_57899/tiff2ps.o:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/tiff2ps.o:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @TIFF2PS(ptr %sampleinfo, i16 %0) {
entry:
  %cmp15 = icmp eq i16 %0, 0
  %land.ext = zext i1 %cmp15 to i32
  store i32 %land.ext, ptr %sampleinfo, align 4
  ret i32 0
}
