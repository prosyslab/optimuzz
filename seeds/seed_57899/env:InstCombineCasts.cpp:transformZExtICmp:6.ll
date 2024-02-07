target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @parse_split_string()
  ret i32 0
}

define internal void @parse_split_string() {
entry:
  %call1 = call ptr @build_argv(ptr null, i8 0)
  ret void
}

define internal ptr @build_argv(ptr %sq, i8 %0) {
entry:
  %tobool9 = trunc i8 %0 to i1
  %lnot = xor i1 %tobool9, true
  %frombool = zext i1 %lnot to i8
  store i8 %frombool, ptr %sq, align 1
  ret ptr null
}
