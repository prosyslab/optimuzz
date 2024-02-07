; ModuleID = 'seeds/seed_57899/cksum:InstCombineCasts.cpp:transformZExtICmp:8.ll'
source_filename = "seeds/seed_57899/cksum:InstCombineCasts.cpp:transformZExtICmp:8.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call150 = call i1 @digest_check()
  ret i32 0
}

define internal i1 @digest_check() {
entry:
  %call431 = call i1 @split_3(ptr null, i8 0)
  ret i1 false
}

define internal i1 @split_3(ptr %s.addr, i8 %0) {
entry:
  %cmp38 = icmp eq i8 %0, 0
  %frombool40 = zext i1 %cmp38 to i8
  store i8 %frombool40, ptr %s.addr, align 1
  ret i1 false
}
