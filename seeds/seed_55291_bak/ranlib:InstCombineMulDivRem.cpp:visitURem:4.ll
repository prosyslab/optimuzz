target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i1 @bfd_is_thin_archive.278()

declare ptr @_bfd_get_elt_at_filepos()

define ptr @bfd_generic_openr_next_archived_file(ptr %filestart, i64 %0) {
entry:
  %filestart1 = alloca i64, align 8
  br label %if.else

if.else:                                          ; preds = %entry
  br label %if.then1

if.then1:                                         ; preds = %if.else
  %1 = load i64, ptr %filestart, align 8
  %rem = urem i64 %0, 2
  %2 = load i64, ptr undef, align 8
  %add2 = add i64 0, 2
  store i64 %rem, ptr %filestart, align 8
  ret ptr null
}
