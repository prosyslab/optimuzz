; ModuleID = 'seeds/seed_57899/gzip:InstCombineCasts.cpp:transformZExtICmp:4.ll'
source_filename = "seeds/seed_57899/gzip:InstCombineCasts.cpp:transformZExtICmp:4.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @check_zipfile(ptr %h, i32 %conv61) {
entry:
  %and62 = and i32 %conv61, 1
  store i32 %and62, ptr %h, align 4
  ret i32 0
}
