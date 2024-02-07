; ModuleID = '/home/doitman/llfuzz-experiment/lls/lls_55291/schismtracker.ll'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.widget = type { i32, %union._widget_data_union, i32, i32, i32, i32, i32, i32, i32, %struct.anon, ptr, ptr, ptr, i32 }
%union._widget_data_union = type { %struct.widget_numentry }
%struct.widget_numentry = type { i32, i32, i32, ptr, ptr, i32 }
%struct.anon = type { i32, i32, i32, i32, i32 }
%struct.song_instrument = type { i32, i32, i32, i32, [128 x i8], [128 x i8], %struct.song_envelope, %struct.song_envelope, %struct.song_envelope, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [32 x i8], [16 x i8], i32 }
%struct.song_envelope = type { [32 x i32], [32 x i8], i32, i32, i32, i32, i32 }

@widgets_general = external dso_local global [18 x %struct.widget]

; Function Attrs: noinline nounwind uwtable
define void @instrument_list_general_load_page() #0 {
entry:
  store ptr @instrument_list_general_predraw_hook, ptr undef, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @instrument_list_general_predraw_hook() #0 {
entry:
  %ins = alloca ptr, align 8
  %0 = load ptr, ptr %ins, align 8
  %nna = getelementptr inbounds %struct.song_instrument, ptr %0, i32 0, i32 9
  %1 = load i32, ptr %nna, align 4
  %rem = urem i32 %1, 4
  %add = add i32 0, %rem
  call void @togglebutton_set(i32 %add)
  ret void
}

; Function Attrs: noinline nounwind uwtable
declare ptr @song_get_instrument() #0

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_aiff_save_sample() #0

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_au_save_sample() #0

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_its_save_sample() #0

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_mod_save_song() #0

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_raw_save_sample() #0

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_s3m_save_song() #0

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_wav_save_sample() #0

; Function Attrs: noinline nounwind uwtable
declare void @togglebutton_set(i32 noundef) #0

; Function Attrs: noinline nounwind uwtable
declare i32 @_save_it() #0

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
