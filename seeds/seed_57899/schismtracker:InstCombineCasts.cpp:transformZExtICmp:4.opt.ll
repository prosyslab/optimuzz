; ModuleID = 'seeds/seed_57899/schismtracker:InstCombineCasts.cpp:transformZExtICmp:4.ll'
source_filename = "seeds/seed_57899/schismtracker:InstCombineCasts.cpp:transformZExtICmp:4.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @song_set_channel_mute(i32)

define void @song_toggle_channel_mute(i32 %0) {
entry:
  %and = and i32 %0, 1
  %1 = xor i32 %and, 1
  call void @song_set_channel_mute(i32 %1)
  ret void
}
