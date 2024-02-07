target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @canonicalize_filename_mode() {
entry:
  %call = call ptr @canonicalize_filename_mode_stk()
  ret ptr null
}

define internal ptr @canonicalize_filename_mode_stk() {
entry:
  %call11 = call i1 @multiple_bits_set(i32 0)
  ret ptr null
}

define internal i1 @multiple_bits_set(i32 %0) {
entry:
  %sub = sub i32 %0, 1
  %and = and i32 %0, %sub
  %cmp = icmp ne i32 %and, 0
  ret i1 %cmp
}
