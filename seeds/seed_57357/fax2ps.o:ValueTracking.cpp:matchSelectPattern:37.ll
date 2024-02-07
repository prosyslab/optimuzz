; ModuleID = '/home/doitman/llfuzz-experiment/lls/lls_55291/fax2ps.o.ll'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define void @printTIF() #0 {
entry:
  %call108 = call i32 (ptr, i32, ...) @TIFFSetField(ptr noundef null, i32 noundef 0, ptr noundef nonnull @printruns) #4
  ret void
}

declare i32 @TIFFGetField(...) #1

declare ptr @TIFFFileName() #1

declare void @TIFFWarning(...) #1

declare i32 @printf(...) #1

; Function Attrs: nounwind
declare i64 @time() #2

; Function Attrs: nounwind
declare ptr @ctime() #2

; Function Attrs: noinline nounwind uwtable
declare void @emitFont() #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #3

; Function Attrs: noinline nounwind uwtable
define internal void @printruns() #0 {
entry:
  %runlength = alloca i32, align 4
  %bitsleft = alloca i32, align 4
  %0 = load i32, ptr %runlength, align 4
  %cmp37 = icmp ugt i32 %0, 0
  %1 = load i32, ptr %runlength, align 4
  %cmp39 = icmp ule i32 %1, 0
  %2 = select i1 %cmp37, i1 %cmp39, i1 false
  br i1 %2, label %while.body41, label %while.end92

while.body41:                                     ; preds = %entry
  store i32 0, ptr %bitsleft, align 4
  br label %while.end92

while.end92:                                      ; preds = %while.body41, %entry
  ret void
}

declare i32 @TIFFSetField(ptr noundef, i32 noundef, ...) #1

declare i32 @TIFFNumberOfStrips() #1

declare i64 @TIFFReadEncodedStrip() #1

declare i32 @putchar() #1

declare i32 @fprintf(...) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #4 = { nounwind }
