; ModuleID = '/home/doitman/llfuzz-experiment/lls/lls_55291/cjpeg.ll'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.jpeg_compress_struct = type { ptr, ptr, ptr, ptr, i32, i32, ptr, i32, i32, i32, i32, double, i32, i32, i32, ptr, [4 x ptr], [4 x ptr], [4 x ptr], [16 x i8], [16 x i8], [16 x i8], i32, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i8, i8, i8, i16, i16, i32, i32, i32, i32, i32, i32, i32, [4 x ptr], i32, i32, i32, [10 x i32], i32, i32, i32, i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32 }

; Function Attrs: argmemonly nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #0

; Function Attrs: nofree nounwind
declare noundef i32 @getc() #1

; Function Attrs: argmemonly nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #0

; Function Attrs: nounwind uwtable
define ptr @jinit_read_ppm(ptr noundef %cinfo) #2 {
entry:
  %mem = getelementptr inbounds %struct.jpeg_compress_struct, ptr %cinfo, i64 0, i32 1
  %0 = load ptr, ptr %mem, align 8
  %1 = load ptr, ptr %0, align 8
  %call = tail call ptr %1(ptr noundef null, i32 noundef 0, i64 noundef 0) #5
  store ptr @start_input_ppm, ptr %call, align 8
  ret ptr null
}

; Function Attrs: nounwind uwtable
define internal void @start_input_ppm(ptr noundef %cinfo, ptr noundef %sinfo) #2 {
entry:
  %call11 = call fastcc i32 @read_pbm_integer()
  %call14 = call fastcc i32 @read_pbm_integer()
  %call17 = call fastcc i32 @read_pbm_integer()
  %cmp18 = icmp eq i32 %call11, 0
  %cmp19 = icmp eq i32 %call14, 0
  %or.cond = select i1 %cmp18, i1 false, i1 %cmp19
  %cmp21 = icmp eq i32 %call17, 0
  %or.cond306 = select i1 %or.cond, i1 false, i1 %cmp21
  br i1 %or.cond306, label %if.then22, label %if.end27

if.then22:                                        ; preds = %entry
  %0 = load ptr, ptr %cinfo, align 8
  br label %if.end27

if.end27:                                         ; preds = %if.then22, %entry
  ret void
}

; Function Attrs: nounwind uwtable
declare fastcc i32 @read_pbm_integer() #2

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fmuladd.f64(double, double, double) #3

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #4

; uselistorder directives
uselistorder ptr @read_pbm_integer, { 2, 1, 0 }

attributes #0 = { argmemonly nocallback nofree nosync nounwind willreturn }
attributes #1 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #4 = { argmemonly nocallback nofree nounwind willreturn }
attributes #5 = { nounwind }
