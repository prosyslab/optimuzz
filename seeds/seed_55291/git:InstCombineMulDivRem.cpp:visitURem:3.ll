target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@anonymize_ident_line.which_buffer = external dso_local global i32

define internal void @anonymize_ident_line(ptr %anonymize_ident_line.which_buffer, i32 %0) {
entry:
  %1 = load i32, ptr %anonymize_ident_line.which_buffer, align 4
  %conv = zext i32 %0 to i64
  %rem = urem i64 %conv, 2
  %conv1 = trunc i64 %rem to i32
  store i32 %conv1, ptr undef, align 4
  ret void
}
