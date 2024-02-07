target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ar = type { i64, i64, i64, i64, ptr, i64, i8 }

@.str.2.598 = external dso_local constant [3 x i8]

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

declare void @archive_entry_set_filetype()

declare void @archive_entry_set_gid()

declare void @archive_entry_set_mode()

declare void @archive_entry_set_mtime()

declare void @archive_entry_set_size()

declare void @archive_entry_set_uid()

define i32 @archive_read_support_format_ar() {
if.end4:
  %call5 = call i32 undef(ptr null, ptr null, ptr null, ptr null, ptr null, ptr @archive_read_format_ar_read_header, ptr null, ptr null, ptr null, ptr null, ptr null, ptr null)
  ret i32 0
}

define internal i32 @archive_read_format_ar_read_header() {
if.end5:
  %call6 = call i32 @_ar_read_header()
  ret i32 0
}

define internal i32 @_ar_read_header() {
if.then212:
  %call2141 = call i32 @ar_parse_common_header(ptr undef, i64 undef, ptr undef)
  ret i32 0
}

define internal i32 @ar_parse_common_header(ptr %n, i64 %0, ptr %entry_padding) {
entry:
  %n1 = alloca i64, align 8
  %1 = load i64, ptr %n, align 8
  %rem = urem i64 %0, 2
  %entry_padding2 = getelementptr inbounds %struct.ar, ptr undef, i32 0, i32 3
  store i64 %rem, ptr %n, align 8
  ret i32 0
}

declare i64 @ar_atol10()

declare i64 @ar_atol8()

attributes #0 = { argmemonly nofree nounwind willreturn }
