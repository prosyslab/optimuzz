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

if.end109:                                        ; No predecessors!
  call void @setup_converter()
  br label %return

return:                                           ; preds = %if.end109, %entry
  ret ptr null
}

define internal void @setup_converter() {
entry:
  br label %if.end118

if.then19:                                        ; No predecessors!
  store i32 0, ptr @best_effort_strncat_to_utf16be, align 4
  br label %if.end118

if.end118:                                        ; preds = %if.then19, %entry
  ret void
}

define internal i32 @best_effort_strncat_to_utf16be() {
entry:
  %call1 = call i32 @best_effort_strncat_to_utf16(ptr null, i8 0)
  ret i32 0
}

define internal i32 @best_effort_strncat_to_utf16(ptr %s, i8 %0) {
entry:
  %conv = sext i8 %0 to i32
  %cmp5 = icmp ugt i32 %conv, 127
  %spec.store.select = select i1 %cmp5, i32 0, i32 1
  store i32 %spec.store.select, ptr %s, align 4
  ret i32 0
}

define ptr @archive_string_conversion_from_charset() {
entry:
  %call1 = call ptr @get_sconv_object()
  ret ptr null
}
