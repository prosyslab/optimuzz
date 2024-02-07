; ModuleID = 'seeds/seed_57899/tiffdump.o:InstCombineCasts.cpp:transformZExtICmp:8.ll'
source_filename = "seeds/seed_57899/tiffdump.o:InstCombineCasts.cpp:transformZExtICmp:8.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  call void @dump(ptr null, i32 0)
  ret i32 0
}

define internal void @dump(ptr %bigendian, i32 %0) {
entry:
  %tobool.not = icmp eq i32 %0, 0
  %lnot.ext = zext i1 %tobool.not to i32
  store i32 %lnot.ext, ptr %bigendian, align 4
  ret void
}
