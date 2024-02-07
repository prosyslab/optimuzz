; ModuleID = 'seeds/seed_57899/bsdcat:InstCombineCasts.cpp:transformZExtICmp:4.ll'
source_filename = "seeds/seed_57899/bsdcat:InstCombineCasts.cpp:transformZExtICmp:4.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @archive_entry_is_data_encrypted(i32 %conv) {
entry:
  %and = and i32 %conv, 1
  %0 = xor i32 %and, 1
  ret i32 %0
}
