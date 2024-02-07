target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.9.205 = private constant [8 x i8] c"UTF16BE\00"

declare i32 @strcmp(ptr, ptr)

define internal ptr @get_sconv_object() {
entry:
  %call61 = call ptr @canonical_charset_name(ptr null)
  ret ptr null
}

define internal ptr @canonical_charset_name(ptr %retval) {
entry:
  %cs = alloca [16 x i8], align 16
  %call35 = call i32 @strcmp(ptr %cs, ptr @.str.9.205)
  %cmp36 = icmp eq i32 %call35, 0
  br i1 %cmp36, label %if.then38, label %if.end39

if.then38:                                        ; preds = %entry
  store ptr null, ptr %retval, align 8
  br label %if.end39

if.end39:                                         ; preds = %if.then38, %entry
  ret ptr null
}

define ptr @archive_string_conversion_from_charset() {
entry:
  %call1 = call ptr @get_sconv_object()
  ret ptr null
}
