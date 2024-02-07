target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.9.1374 = private constant [8 x i8] c"UTF16BE\00"

declare i32 @strcmp(ptr, ptr)

define ptr @archive_string_conversion_to_charset() {
entry:
  %call1 = call ptr @get_sconv_object()
  ret ptr null
}

define internal ptr @get_sconv_object() {
entry:
  br label %return

if.then2:                                         ; No predecessors!
  %call61 = call ptr @canonical_charset_name(ptr null)
  br label %return

return:                                           ; preds = %if.then2, %entry
  ret ptr null
}

define internal ptr @canonical_charset_name(ptr %retval) {
entry:
  %cs = alloca [16 x i8], align 16
  %call35 = call i32 @strcmp(ptr %cs, ptr @.str.9.1374)
  %cmp36 = icmp eq i32 %call35, 0
  br i1 %cmp36, label %if.then38, label %common.ret

common.ret:                                       ; preds = %if.then38, %entry
  ret ptr null

if.then38:                                        ; preds = %entry
  store ptr null, ptr %retval, align 8
  br label %common.ret
}
