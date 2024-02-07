target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @relpath(ptr %relto_suffix, i8 %0) {
entry:
  %tobool26 = trunc i8 %0 to i1
  %frombool30 = zext i1 %tobool26 to i8
  store i8 %frombool30, ptr %relto_suffix, align 1
  ret i1 false
}
