; ModuleID = 'seeds/seed_57899/swftoperl-main.o:InstCombineCasts.cpp:transformZExtICmp:8.ll'
source_filename = "seeds/seed_57899/swftoperl-main.o:InstCombineCasts.cpp:transformZExtICmp:8.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
if.end21:
  %call221 = call i32 @readMovieHeader(i32 0, ptr null)
  ret i32 0
}

define internal i32 @readMovieHeader(i32 %call, ptr %compressed.addr) {
entry:
  %cmp = icmp eq i32 %call, 0
  %cond = zext i1 %cmp to i32
  store i32 %cond, ptr %compressed.addr, align 4
  ret i32 0
}
