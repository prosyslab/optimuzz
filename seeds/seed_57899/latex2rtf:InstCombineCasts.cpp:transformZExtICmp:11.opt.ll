; ModuleID = 'seeds/seed_57899/latex2rtf:InstCombineCasts.cpp:transformZExtICmp:11.ll'
source_filename = "seeds/seed_57899/latex2rtf:InstCombineCasts.cpp:transformZExtICmp:11.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @diagnostics(i32, ptr, ...)

define void @CmdEquation(i32 %0) {
entry:
  %cmp10 = icmp eq i32 %0, 0
  %lor.ext = zext i1 %cmp10 to i32
  call void (i32, ptr, ...) @diagnostics(i32 0, ptr null, i32 %lor.ext, i32 0)
  ret void
}
