target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @fprintftime() {
entry:
  %call1 = call i64 @__strftime_internal(ptr null, i1 false)
  ret i64 0
}

define internal i64 @__strftime_internal(ptr %format_char, i1 %cmp452) {
entry:
  %cond454 = select i1 %cmp452, i32 99, i32 0
  %cmp455 = icmp ult i32 %cond454, 1
  %frombool459 = zext i1 %cmp455 to i8
  store i8 %frombool459, ptr %format_char, align 1
  ret i64 0
}
