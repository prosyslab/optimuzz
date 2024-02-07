; ModuleID = 'seeds/seed_57899/split:InstCombineCasts.cpp:transformZExtICmp:11.ll'
source_filename = "seeds/seed_57899/split:InstCombineCasts.cpp:transformZExtICmp:11.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @path_search(ptr %dir.addr, i8 %0) {
entry:
  %cmp30 = icmp ne i8 %0, 0
  %frombool32 = zext i1 %cmp30 to i8
  store i8 %frombool32, ptr %dir.addr, align 1
  ret i32 0
}
