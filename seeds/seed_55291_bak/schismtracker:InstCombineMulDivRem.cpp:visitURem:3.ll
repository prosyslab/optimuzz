; ModuleID = '/home/doitman/llfuzz-experiment/lls/lls_55291/schismtracker.ll'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.it_instrument = type { [4 x i8], [13 x i8], i8, i8, i8, i16, i8, i8, i8, i8, i8, i8, i16, i8, i8, [26 x i8], i8, i8, i8, i8, i16, [120 x %struct.it_notetrans], %struct.it_envelope, %struct.it_envelope, %struct.it_envelope }
%struct.it_notetrans = type { i8, i8 }
%struct.it_envelope = type { i8, i8, i8, i8, i8, i8, [25 x %struct.anon.204], i8 }
%struct.anon.204 = type <{ i8, i16 }>
%struct.song_instrument = type { i32, i32, i32, i32, [128 x i8], [128 x i8], %struct.song_envelope, %struct.song_envelope, %struct.song_envelope, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [32 x i8], [16 x i8], i32 }
%struct.song_envelope = type { [32 x i32], [32 x i8], i32, i32, i32, i32, i32 }

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #0

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_aiff_save_sample() #2

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_au_save_sample() #2

; Function Attrs: noinline nounwind uwtable
define i32 @fmt_it_load_song() #2 {
if.end415:
  %cond428 = select i1 false, ptr @load_it_instrument, ptr null
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define internal void @load_it_instrument() #2 {
entry:
  %ihdr = alloca %struct.it_instrument, align 1
  %nna = getelementptr inbounds %struct.it_instrument, ptr %ihdr, i32 0, i32 2
  %0 = load i8, ptr %nna, align 1
  %conv = zext i8 %0 to i32
  %rem = srem i32 %conv, 4
  %nna9 = getelementptr inbounds %struct.song_instrument, ptr undef, i32 0, i32 9
  store i32 %rem, ptr %nna9, align 4
  ret void
}

; Function Attrs: noinline nounwind uwtable
declare void @load_it_notetrans() #2

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_its_save_sample() #2

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_mod_save_song() #2

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_raw_save_sample() #2

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_s3m_save_song() #2

; Function Attrs: noinline nounwind uwtable
declare i32 @fmt_wav_save_sample() #2

; Function Attrs: noinline nounwind uwtable
declare i64 @slurp_read() #2

; Function Attrs: noinline nounwind uwtable
declare i32 @_save_it() #2

; uselistorder directives
uselistorder i32 0, { 1, 2, 0 }

attributes #0 = { argmemonly nofree nounwind willreturn writeonly }
attributes #1 = { argmemonly nofree nounwind willreturn }
attributes #2 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
