; ModuleID = 'seeds/seed_57899/id:InstCombineCasts.cpp:transformZExtICmp:11.ll'
source_filename = "seeds/seed_57899/id:InstCombineCasts.cpp:transformZExtICmp:11.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @mgetgroups(i32 %0) {
entry:
  %cmp56 = icmp ne i32 %0, 0
  %conv57 = zext i1 %cmp56 to i32
  %call60 = call i32 @getgroups(i32 %conv57)
  ret i32 0
}

declare i32 @getgroups(i32)
