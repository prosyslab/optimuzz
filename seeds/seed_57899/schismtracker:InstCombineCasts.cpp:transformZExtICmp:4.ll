target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @song_set_channel_mute(i32)

define void @song_toggle_channel_mute(i32 %0) {
entry:
  %and = and i32 %0, 1
  %cmp = icmp eq i32 %and, 0
  %conv = zext i1 %cmp to i32
  call void @song_set_channel_mute(i32 %conv)
  ret void
}
