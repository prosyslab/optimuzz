; ModuleID = 'seeds/seed_57899/df:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/df:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @dir_len(ptr %file.addr, i8 %0) {
entry:
  %cmp1 = icmp eq i8 %0, 0
  %conv4 = zext i1 %cmp1 to i64
  store i64 %conv4, ptr %file.addr, align 8
  ret i64 0
}
