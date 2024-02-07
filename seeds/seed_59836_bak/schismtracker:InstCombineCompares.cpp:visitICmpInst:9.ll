target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.au_header = type { [4 x i8], i32, i32, i32, i32, i32 }

@.str.704 = private constant [5 x i8] c".snd\00"

declare i32 @memcmp(ptr, ptr, i64)

define i32 @fmt_au_load_sample(ptr %retval) {
entry:
  %au = alloca %struct.au_header, align 4
  %call10 = call i32 @memcmp(ptr %au, ptr @.str.704, i64 4)
  %cmp11 = icmp eq i32 %call10, 0
  br i1 %cmp11, label %common.ret, label %if.then12

common.ret:                                       ; preds = %if.then12, %entry
  ret i32 0

if.then12:                                        ; preds = %entry
  store i32 0, ptr %retval, align 4
  br label %common.ret
}
