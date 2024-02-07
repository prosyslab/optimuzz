; ModuleID = 'seeds/seed_57899/fax2ps.o:InstCombineCasts.cpp:transformZExtICmp:8.ll'
source_filename = "seeds/seed_57899/fax2ps.o:InstCombineCasts.cpp:transformZExtICmp:8.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @findPage(ptr %pn, i32 %conv8) {
entry:
  %cmp10 = icmp eq i32 %conv8, 0
  %conv11 = zext i1 %cmp10 to i32
  store i32 %conv11, ptr %pn, align 4
  ret i32 0
}
