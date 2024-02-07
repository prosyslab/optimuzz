; ModuleID = 'seeds/seed_57899/fax2tiff.o:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/fax2tiff.o:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i32 %0) {
entry:
  %tobool213.not = icmp ne i32 %0, 0
  %cond214 = zext i1 %tobool213.not to i32
  %call215 = call i32 (ptr, i32, ...) @TIFFSetField(ptr null, i32 0, i32 %cond214)
  ret i32 0
}

declare i32 @TIFFSetField(ptr, i32, ...)
