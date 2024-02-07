; ModuleID = 'seeds/seed_57899/readelf:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/readelf:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @ctf_bufopen_internal() {
entry:
  %call4821 = call i32 @init_types(ptr null, i32 0)
  ret ptr null
}

define internal i32 @init_types(ptr %cth.addr, i32 %0) {
entry:
  %cmp = icmp ne i32 %0, 0
  %conv = zext i1 %cmp to i32
  store i32 %conv, ptr %cth.addr, align 4
  ret i32 0
}
