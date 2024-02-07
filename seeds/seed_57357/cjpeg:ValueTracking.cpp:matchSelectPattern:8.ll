; ModuleID = '/home/doitman/llfuzz-experiment/lls/lls_55291/cjpeg.ll'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.jpeg_compress_struct = type { ptr, ptr, ptr, ptr, i32, i32, ptr, i32, i32, i32, i32, double, i32, i32, i32, ptr, [4 x ptr], [4 x ptr], [4 x ptr], [16 x i8], [16 x i8], [16 x i8], i32, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i8, i8, i8, i16, i16, i32, i32, i32, i32, i32, i32, i32, [4 x ptr], i32, i32, i32, [10 x i32], i32, i32, i32, i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32 }
%struct.cjpeg_source_struct = type { ptr, ptr, ptr, ptr, ptr, i32 }

; Function Attrs: argmemonly nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #0

; Function Attrs: nofree nounwind
declare noundef i64 @fread() #1

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
define internal void @start_input_ppm(ptr noundef %sinfo) #2 {
entry:
  %get_pixel_rows219 = getelementptr inbounds %struct.cjpeg_source_struct, ptr %sinfo, i64 0, i32 1
  store ptr @get_rgb_cmyk_row, ptr %get_pixel_rows219, align 8
  ret void
}

; Function Attrs: nounwind uwtable
declare fastcc i32 @read_pbm_integer() #2

; Function Attrs: nounwind uwtable
define internal i32 @get_rgb_cmyk_row(ptr nocapture noundef readonly %sinfo) #2 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %ptr.0116 = phi ptr [ null, %for.body ], [ null, %entry ]
  %bufferptr.0115 = phi ptr [ %incdec.ptr11, %for.body ], [ null, %entry ]
  %0 = load i8, ptr %bufferptr.0115, align 1
  %conv.i = uitofp i8 %0 to double
  %div.i = fdiv double %conv.i, 0.000000e+00
  %sub.i = fsub double 0.000000e+00, %div.i
  %cmp.i = fcmp olt double %sub.i, 0.000000e+00
  %cond.sub6.i = select i1 %cmp.i, double 1.000000e+00, double 0.000000e+00
  %add.ptr13 = getelementptr inbounds i8, ptr %ptr.0116, i64 3
  %incdec.ptr11 = getelementptr inbounds i8, ptr %bufferptr.0115, i64 3
  %neg38.i = fneg double %cond.sub6.i
  %1 = tail call double @llvm.fmuladd.f64(double %neg38.i, double 0.000000e+00, double 0.000000e+00) #5
  %add39.i = fadd double %1, 0.000000e+00
  %conv40.i = fptoui double %add39.i to i8
  store i8 %conv40.i, ptr %add.ptr13, align 1
  %add.ptr14 = getelementptr inbounds i8, ptr %ptr.0116, i64 4
  br label %for.body
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fmuladd.f64(double, double, double) #3

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #4

attributes #0 = { argmemonly nocallback nofree nosync nounwind willreturn }
attributes #1 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #4 = { argmemonly nocallback nofree nounwind willreturn }
attributes #5 = { nounwind }
