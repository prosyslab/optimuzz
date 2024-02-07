; ModuleID = 'seeds/seed_57899/firejail:InstCombineCasts.cpp:transformZExtICmp:11.ll'
source_filename = "seeds/seed_57899/firejail:InstCombineCasts.cpp:transformZExtICmp:11.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ascii_isalnum(i32 %call) {
entry:
  %tobool.not = icmp eq i32 %call, 0
  %lor.ext = zext i1 %tobool.not to i32
  ret i32 %lor.ext
}
