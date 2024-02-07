target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @archive_read_support_format_ar() {
entry:
  br label %return

if.end:                                           ; No predecessors!
  %call5 = load i32, ptr @archive_read_format_ar_read_header, align 4
  br label %return

return:                                           ; preds = %if.end, %entry
  ret i32 0
}

define internal i32 @archive_read_format_ar_read_header() {
entry:
  %call6 = call i32 @_ar_read_header()
  ret i32 0
}

define internal i32 @_ar_read_header() {
entry:
  br label %return

if.then65:                                        ; No predecessors!
  %call811 = call i64 @ar_atol10(ptr null)
  br label %return

return:                                           ; preds = %if.then65, %entry
  ret i32 0
}

define internal i64 @ar_atol10(ptr %last_digit_limit) {
entry:
  store i32 0, ptr %last_digit_limit, align 4
  %0 = load i32, ptr %last_digit_limit, align 4
  %conv1 = zext i32 %0 to i64
  %rem = urem i64 1, %conv1
  store i64 %rem, ptr %last_digit_limit, align 8
  ret i64 0
}
