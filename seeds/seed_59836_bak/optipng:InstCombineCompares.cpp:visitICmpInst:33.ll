target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.193 = private constant [2 x i8] c"/\00"

declare ptr @strchr(ptr, i32)

define ptr @opng_path_replace_dir(ptr %buffer.addr, i32 %conv) {
entry:
  %call10 = call ptr @strchr(ptr @.str.193, i32 %conv)
  %cmp11 = icmp eq ptr %call10, null
  br i1 %cmp11, label %if.then13, label %if.end15

if.then13:                                        ; preds = %entry
  %0 = load ptr, ptr %buffer.addr, align 8
  br label %if.end15

if.end15:                                         ; preds = %if.then13, %entry
  ret ptr null
}
