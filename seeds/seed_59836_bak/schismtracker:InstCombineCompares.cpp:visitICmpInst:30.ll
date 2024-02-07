target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.song = type { [1024 x i32], [256 x %struct.song_voice], [256 x i32], [237 x %struct.song_sample], [237 x ptr], [64 x %struct.info_window], [240 x ptr], [240 x i16], [240 x i16], [257 x i8], %struct.midi_config_t, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i8, i8, [8001 x i8], [32 x i8], [32 x i8], i32, ptr, %struct.timespec, i32, i32, i32, i32, i32, i32, i32, i32, i32, ptr }
%struct.song_voice = type { ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, ptr, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i16, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }
%struct.song_sample = type { i32, i32, i32, i32, i32, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, [32 x i8], [22 x i8], i32, i32, [12 x i8] }
%struct.info_window = type { i32, i32, i32 }
%struct.midi_config_t = type { [32 x i8], [32 x i8], [32 x i8], [32 x i8], [32 x i8], [32 x i8], [32 x i8], [32 x i8], [32 x i8], [16 x [32 x i8]], [128 x [32 x i8]] }
%struct.timespec = type { i64, i64 }

define void @csf_process_effects(ptr %chan, ptr %0) {
entry:
  %1 = load ptr, ptr %chan, align 8
  %samples73 = getelementptr %struct.song, ptr %0, i32 0, i32 3
  %cmp76 = icmp ne ptr %1, %samples73
  br i1 %cmp76, label %common.ret, label %lor.lhs.false78

common.ret:                                       ; preds = %lor.lhs.false78, %entry
  ret void

lor.lhs.false78:                                  ; preds = %entry
  %2 = load ptr, ptr %chan, align 8
  br label %common.ret
}
