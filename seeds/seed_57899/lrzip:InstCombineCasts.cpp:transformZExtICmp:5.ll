target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @open_tmpoutfile(i64 %0) {
entry:
  %and55 = and i64 %0, 524288
  %tobool56 = icmp ne i64 %and55, 0
  %lor.ext = zext i1 %tobool56 to i32
  %conv59 = trunc i32 %lor.ext to i8
  call void @register_outfile(i8 %conv59)
  ret i32 0
}

declare void @register_outfile(i8)
