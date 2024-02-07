; ModuleID = 'seeds/seed_57899/schismtracker:InstCombineCasts.cpp:transformZExtICmp:9.ll'
source_filename = "seeds/seed_57899/schismtracker:InstCombineCasts.cpp:transformZExtICmp:9.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @draw_widget(ptr %w.addr, i32 %0) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  store i32 0, ptr %w.addr, align 4
  br label %for.cond
}
