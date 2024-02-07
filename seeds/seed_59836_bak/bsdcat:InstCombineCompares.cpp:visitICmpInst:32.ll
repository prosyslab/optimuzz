target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal ptr @get_sconv_object() {
entry:
  br label %return

if.then2:                                         ; No predecessors!
  %call8 = call ptr @create_sconv_object()
  br label %return

return:                                           ; preds = %if.then2, %entry
  ret ptr null
}

define internal ptr @create_sconv_object() {
entry:
  br label %return

if.end11:                                         ; No predecessors!
  call void @setup_converter()
  br label %return

return:                                           ; preds = %if.end11, %entry
  ret ptr null
}

define internal void @setup_converter() {
entry:
  br label %if.end118

if.then47:                                        ; No predecessors!
  store i32 0, ptr @archive_string_append_unicode, align 4
  br label %if.end118

if.end118:                                        ; preds = %if.then47, %entry
  ret void
}

define internal i32 @archive_string_append_unicode() {
entry:
  %unparse = alloca ptr, align 8
  br label %return

if.then9:                                         ; No predecessors!
  store ptr @unicode_to_utf8, ptr %unparse, align 8
  br label %return

return:                                           ; preds = %if.then9, %entry
  ret i32 0
}

define internal i64 @unicode_to_utf8() {
entry:
  %remaining.addr = alloca i64, align 8
  %uc.addr = alloca i32, align 4
  %0 = load i32, ptr %uc.addr, align 4
  %cmp = icmp ugt i32 %0, 1
  %spec.store.select = select i1 %cmp, i32 65533, i32 0
  store i32 %spec.store.select, ptr %uc.addr, align 4
  %1 = load i32, ptr %uc.addr, align 4
  %cmp1 = icmp ule i32 %1, 0
  br i1 %cmp1, label %if.then2, label %common.ret

common.ret:                                       ; preds = %if.then2, %entry
  ret i64 0

if.then2:                                         ; preds = %entry
  %2 = load i64, ptr %remaining.addr, align 8
  br label %common.ret
}

define ptr @archive_string_conversion_from_charset() {
entry:
  %call1 = call ptr @get_sconv_object()
  ret ptr null
}
