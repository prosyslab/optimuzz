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
  store i32 0, ptr @strncat_from_utf8_libarchive2, align 4
  ret void
}

define internal i32 @strncat_from_utf8_libarchive2() align 4 {
entry:
  br label %return

if.end:                                           ; No predecessors!
  %call91 = call i32 @_utf8_to_unicode(ptr null)
  br label %return

return:                                           ; preds = %if.end, %entry
  ret i32 0
}

define internal i32 @_utf8_to_unicode(ptr %cnt) {
entry:
  %ch = alloca i32, align 4
  %0 = load i32, ptr %ch, align 4
  %cmp106 = icmp eq i32 %0, 192
  %1 = load i32, ptr %ch, align 4
  %cmp108 = icmp eq i32 %1, 193
  %or.cond = select i1 %cmp106, i1 true, i1 %cmp108
  br i1 %or.cond, label %if.then110, label %common.ret

common.ret:                                       ; preds = %if.then110, %entry
  ret i32 0

if.then110:                                       ; preds = %entry
  store i32 0, ptr %cnt, align 4
  br label %common.ret
}

define ptr @archive_string_conversion_from_charset() {
entry:
  %call1 = call ptr @get_sconv_object()
  ret ptr null
}
