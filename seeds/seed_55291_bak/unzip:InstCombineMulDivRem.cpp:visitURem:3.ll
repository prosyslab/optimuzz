target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Globals = type { %struct._UzpOpts, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i64, i64, i64, ptr, ptr, [4 x i8], [10 x i8], [16384 x %struct.min_info], ptr, %union.work, ptr, i64, ptr, ptr, i32, i64, i32, i32, ptr, ptr, ptr, i32, i64, i64, i64, ptr, ptr, %struct.local_file_header, %struct.central_directory_file_header, %struct.end_central_dir_record, %struct.stat, i32, ptr, i64, i32, i32, i32, i32, i64, i32, i32, i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i64, [4096 x i8], ptr, i32, [3 x i32], i32, i32, ptr, ptr, i32, i32, ptr, ptr, i32, i32, ptr, ptr, i32, i32, ptr, ptr, ptr, i32, i64, i32, [4 x [24 x i8]], i32, ptr, ptr, ptr, ptr, ptr, i32, ptr, i32, i32, i32, i32, i32, ptr, ptr, ptr, ptr, ptr, [4096 x i8], i32, i32, i32, i32, ptr }
%struct._UzpOpts = type { ptr, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }
%struct.min_info = type { i64, i64, i64, i64, i16, i8, i8, i32, i8, ptr }
%union.work = type { %struct.anon, [16384 x i8] }
%struct.anon = type { [8192 x i32], [8192 x i8], [8192 x i8] }
%struct.local_file_header = type { i64, i64, i64, i64, [2 x i8], i16, i16, i16, i16 }
%struct.central_directory_file_header = type { i64, i64, i64, i64, i64, i64, i16, i16, [2 x i8], [2 x i8], i16, i16, i16, i16, i16 }
%struct.end_central_dir_record = type { i64, i64, i32, i32, i16, i16, i32, i32, i16 }
%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.timespec = type { i64, i64 }

@VersionMsg = external dso_local constant [60 x i8]
@.str.5.221 = external dso_local constant [4 x i8]
@G = external global %struct.Globals

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #0

declare i32 @sprintf(ptr, ptr, ...)

define i32 @extract_or_test_files() {
if.then144:
  %call1451 = call i32 @store_info(ptr undef, i8 undef)
  ret i32 0
}

declare ptr @fnfilter()

define internal i32 @store_info(ptr %0, i8 %1) {
if.then46:
  %2 = load i8, ptr %0, align 2
  %conv48 = zext i8 %1 to i32
  %rem = srem i32 %conv48, 10
  %call49 = call i32 (ptr, ptr, ...) @sprintf(ptr null, ptr null, ptr null, ptr null, i32 0, i32 %rem, i32 0, i32 0)
  ret i32 0
}

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
