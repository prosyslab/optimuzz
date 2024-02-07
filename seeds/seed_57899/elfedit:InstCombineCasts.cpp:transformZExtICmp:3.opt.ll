; ModuleID = 'seeds/seed_57899/elfedit:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/elfedit:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @expandargv() {
entry:
  %call471 = call i32 @only_whitespace(i8 0)
  ret void
}

define internal i32 @only_whitespace(i8 %0) {
entry:
  %cmp6 = icmp eq i8 %0, 0
  %conv7 = zext i1 %cmp6 to i32
  ret i32 %conv7
}
