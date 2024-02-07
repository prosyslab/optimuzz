; ModuleID = 'seeds/seed_57899/base32:InstCombineCasts.cpp:transformZExtICmp:8.ll'
source_filename = "seeds/seed_57899/base32:InstCombineCasts.cpp:transformZExtICmp:8.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @base32_encode_alloc(ptr %inlen.addr, i64 %0) {
entry:
  %cmp = icmp ne i64 %0, 0
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, ptr %inlen.addr, align 8
  ret i64 0
}
