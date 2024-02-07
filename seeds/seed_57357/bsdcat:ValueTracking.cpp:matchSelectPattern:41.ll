; ModuleID = '/home/doitman/llfuzz-experiment/lls/lls_55291/bsdcat.ll'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noreturn nounwind
declare void @exit() #0

; Function Attrs: argmemonly nocallback nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #1

; Function Attrs: nounwind readonly willreturn
declare i32 @strcmp() #2

; Function Attrs: nounwind readonly willreturn
declare i64 @strlen() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start(ptr) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end(ptr) #3

; Function Attrs: nounwind allocsize(0,1)
declare noalias ptr @calloc(i64 noundef, i64 noundef) #4

; Function Attrs: nounwind
declare void @free() #5

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memmove.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1 immarg) #6

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #6

; Function Attrs: nounwind allocsize(1)
declare ptr @realloc(ptr noundef, i64 noundef) #7

declare i64 @write() #8

; Function Attrs: nounwind readnone willreturn
declare ptr @__errno_location() #9

; Function Attrs: nounwind readonly willreturn
declare i64 @wcslen() #2

; Function Attrs: nounwind
declare noalias ptr @strdup() #5

; Function Attrs: noinline nounwind uwtable
declare ptr @archive_string_append() #10

; Function Attrs: noinline nounwind uwtable
declare ptr @archive_string_ensure() #10

; Function Attrs: noinline nounwind uwtable
declare void @archive_string_free() #10

; Function Attrs: noinline nounwind uwtable
declare ptr @archive_strncat() #10

; Function Attrs: noinline nounwind uwtable
declare ptr @archive_strcat() #10

; Function Attrs: noinline nounwind uwtable
declare ptr @archive_strappend_char() #10

; Function Attrs: noinline nounwind uwtable
declare i32 @archive_string_append_from_wcs() #10

; Function Attrs: nounwind
declare i64 @__ctype_get_mb_cur_max() #5

; Function Attrs: nounwind
declare i64 @wcrtomb() #5

; Function Attrs: noinline nounwind uwtable
declare ptr @get_current_charset() #10

; Function Attrs: noinline nounwind uwtable
define internal ptr @get_sconv_object() #10 {
entry:
  %call8 = call ptr @create_sconv_object()
  ret ptr null
}

; Function Attrs: noinline nounwind uwtable
declare ptr @find_sconv_object() #10

; Function Attrs: noinline nounwind uwtable
declare i32 @get_current_codepage() #10

; Function Attrs: noinline nounwind uwtable
declare ptr @canonical_charset_name() #10

; Function Attrs: noinline nounwind uwtable
define internal ptr @create_sconv_object() #10 {
entry:
  call void @setup_converter()
  ret ptr null
}

; Function Attrs: noinline nounwind uwtable
declare void @free_sconv_object() #10

; Function Attrs: noinline nounwind uwtable
declare void @add_sconv_object() #10

declare i32 @iconv_close() #8

; Function Attrs: noinline nounwind uwtable
declare i32 @make_codepage_from_charset() #10

declare ptr @iconv_open() #8

; Function Attrs: noinline nounwind uwtable
define internal void @setup_converter() #10 {
entry:
  call void @add_converter(ptr nonnull @archive_string_append_unicode)
  ret void
}

; Function Attrs: noinline nounwind uwtable
declare void @add_converter(ptr noundef) #10

; Function Attrs: noinline nounwind uwtable
define internal i32 @archive_string_append_unicode() #10 {
entry:
  %parse = alloca ptr, align 8
  store ptr @cesu8_to_unicode, ptr %parse, align 8
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @cesu8_to_unicode() #10 {
entry:
  %wc = alloca i32, align 4
  %cnt = alloca i32, align 4
  %wc2 = alloca i32, align 4
  %0 = load i32, ptr %cnt, align 4
  %cmp = icmp eq i32 %0, 0
  %1 = load i32, ptr %wc, align 4
  %cmp1 = icmp uge i32 %1, 1
  %or.cond = select i1 %cmp, i1 %cmp1, i1 false
  %2 = load i32, ptr %wc, align 4
  %cmp3 = icmp ule i32 %2, 0
  %or.cond1 = select i1 %or.cond, i1 %cmp3, i1 false
  br i1 %or.cond1, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 0, ptr %wc2, align 4
  br label %if.else

if.else:                                          ; preds = %if.then, %entry
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
declare i32 @_utf8_to_unicode(ptr noundef) #10

; Function Attrs: noinline nounwind uwtable
declare i32 @combine_surrogate_pair() #10

; Function Attrs: noinline nounwind uwtable
declare ptr @default_iconv_charset() #10

; Function Attrs: noinline nounwind uwtable
declare i32 @get_current_oemcp() #10

; Function Attrs: nounwind
declare ptr @nl_langinfo() #5

; Function Attrs: noinline nounwind uwtable
define ptr @archive_string_conversion_from_charset() #10 {
entry:
  %call1 = call ptr @get_sconv_object()
  ret ptr null
}

; Function Attrs: noinline nounwind uwtable
declare void @archive_set_error(...) #10

; Function Attrs: noinline noreturn nounwind uwtable
declare void @__archive_errx() #11

; Function Attrs: noinline nounwind uwtable
declare void @archive_string_vsprintf() #10

; Function Attrs: noinline nounwind uwtable
declare void @append_int() #10

; Function Attrs: noinline nounwind uwtable
declare void @append_uint() #10

attributes #0 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nocallback nofree nounwind willreturn writeonly }
attributes #2 = { nounwind readonly willreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind willreturn }
attributes #4 = { nounwind allocsize(0,1) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { argmemonly nocallback nofree nounwind willreturn }
attributes #7 = { nounwind allocsize(1) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { nounwind readnone willreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { noinline noreturn nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
