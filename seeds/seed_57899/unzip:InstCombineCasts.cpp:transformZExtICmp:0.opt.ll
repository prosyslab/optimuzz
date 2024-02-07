; ModuleID = 'seeds/seed_57899/unzip:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/unzip:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @memextract(i16 %0) {
entry:
  %cmp = icmp eq i16 %0, 0
  %conv7 = zext i1 %cmp to i32
  %call8 = call i32 @inflate(i32 %conv7)
  ret i32 0
}

declare i32 @inflate(i32)
