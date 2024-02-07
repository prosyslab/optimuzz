; ModuleID = 'seeds/seed_57899/printf:InstCombineCasts.cpp:transformZExtICmp:11.ll'
source_filename = "seeds/seed_57899/printf:InstCombineCasts.cpp:transformZExtICmp:11.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @unicode_to_mb(i32 %call1, ptr %unicode_to_mb.is_utf8) {
entry:
  %tobool2.not = icmp eq i32 %call1, 0
  %lnot.ext = zext i1 %tobool2.not to i32
  store i32 %lnot.ext, ptr %unicode_to_mb.is_utf8, align 4
  ret i64 0
}
