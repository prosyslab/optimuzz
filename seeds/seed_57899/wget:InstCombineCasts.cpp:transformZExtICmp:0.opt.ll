; ModuleID = 'seeds/seed_57899/wget:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/wget:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ftp_list(ptr %respline, i64 %0) {
entry:
  %cmp27 = icmp eq i64 %0, 0
  %frombool29 = zext i1 %cmp27 to i8
  store i8 %frombool29, ptr %respline, align 1
  ret i32 0
}
