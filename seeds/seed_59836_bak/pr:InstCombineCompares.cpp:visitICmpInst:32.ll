target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @nstrftime() {
entry:
  %call1 = call i64 @__strftime_internal(ptr null, i8 0)
  ret i64 0
}

define internal i64 @__strftime_internal(ptr %format_char, i8 %0) {
entry:
  %tobool421 = trunc i8 %0 to i1
  %spec.select = select i1 %tobool421, i32 45, i32 0
  %conv430 = trunc i32 %spec.select to i8
  %tobool434 = icmp ne i8 %conv430, 0
  %lnot.ext438 = zext i1 %tobool434 to i32
  store i32 %lnot.ext438, ptr %format_char, align 4
  ret i64 0
}
