; ModuleID = '/home/doitman/llfuzz-experiment/lls/lls_55291/tiffcp.o.ll'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
for.cond152:
  %call153 = call i32 @tiffcp()
  ret i32 0
}

declare i32 @TIFFGetField(ptr noundef, ...) #1

; Function Attrs: noinline nounwind uwtable
define internal i32 @tiffcp() #0 {
for.end:
  %call393 = call ptr @pickCopyFunc()
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define internal ptr @pickCopyFunc() #0 {
sw.bb73:
  store ptr @cpSeparateTiles2ContigTiles, ptr undef, align 8
  ret ptr null
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @cpSeparateTiles2ContigTiles() #0 {
entry:
  %call = call i32 undef(ptr noundef null, ptr noundef null, ptr noundef @readSeparateTilesIntoBuffer, ptr noundef null, i32 noundef 0, i32 noundef 0, i16 noundef zeroext 0)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
declare ptr @limitMalloc() #0

declare void @_TIFFmemset() #1

; Function Attrs: noinline nounwind uwtable
define internal i32 @readSeparateTilesIntoBuffer() #0 {
entry:
  %bps = alloca i16, align 2
  br label %if.end

if.end:                                           ; preds = %entry
  br label %if.end12

if.end12:                                         ; preds = %if.end
  br label %if.end21

if.end21:                                         ; preds = %if.end12
  %0 = load i16, ptr %bps, align 2
  %conv22 = zext i16 %0 to i32
  %rem = srem i32 %conv22, 8
  %cmp23 = icmp ne i32 %rem, 0
  br i1 %cmp23, label %if.then25, label %if.end27

if.then25:                                        ; preds = %if.end21
  %1 = load ptr, ptr undef, align 8
  ret i32 0

if.end27:                                         ; preds = %if.end21
  ret i32 0
}

declare i64 @TIFFRasterScanlineSize() #1

declare i64 @TIFFTileRowSize() #1

declare i64 @TIFFTileSize() #1

; uselistorder directives
uselistorder i32 0, { 0, 1, 7, 2, 3, 4, 5, 6 }

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
