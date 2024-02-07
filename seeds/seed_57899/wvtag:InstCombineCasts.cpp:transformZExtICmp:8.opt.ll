; ModuleID = 'seeds/seed_57899/wvtag:InstCombineCasts.cpp:transformZExtICmp:8.ll'
source_filename = "seeds/seed_57899/wvtag:InstCombineCasts.cpp:transformZExtICmp:8.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @copy_timestamp(i32 %call) {
entry:
  %cmp = icmp eq i32 %call, 0
  %retval.0 = zext i1 %cmp to i32
  ret i32 %retval.0
}
