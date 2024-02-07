; ModuleID = 'seeds/seed_57899/lrzip:InstCombineCasts.cpp:transformZExtICmp:12.ll'
source_filename = "seeds/seed_57899/lrzip:InstCombineCasts.cpp:transformZExtICmp:12.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @_ZN7libzpaq5ZPAQL7executeEv(ptr %this.addr, i32 %0, i32 %1) {
entry:
  %cmp = icmp eq i32 %0, %1
  %conv1133 = zext i1 %cmp to i32
  store i32 %conv1133, ptr %this.addr, align 4
  ret i32 0
}
