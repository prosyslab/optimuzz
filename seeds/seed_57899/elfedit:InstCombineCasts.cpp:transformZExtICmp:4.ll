target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call104 = call i32 @process_file()
  ret i32 0
}

define internal i32 @process_file() {
entry:
  %call151 = call i32 @process_archive(i8 0)
  ret i32 0
}

define internal i32 @process_archive(i8 %0) {
entry:
  %tobool = trunc i8 %0 to i1
  %conv = zext i1 %tobool to i32
  %call9 = call i32 @setup_archive(i32 %conv)
  ret i32 0
}

declare i32 @setup_archive(i32)
