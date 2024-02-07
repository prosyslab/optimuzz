; ModuleID = 'seeds/seed_57899/bsdcpio:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/bsdcpio:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @__archive_pathmatch(ptr %s.addr, i8 %0) {
entry:
  %cmp6 = icmp eq i8 %0, 0
  %lor.ext = zext i1 %cmp6 to i32
  store i32 %lor.ext, ptr %s.addr, align 4
  ret i32 0
}
