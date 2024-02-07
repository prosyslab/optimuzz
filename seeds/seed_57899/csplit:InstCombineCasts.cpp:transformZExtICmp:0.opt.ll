; ModuleID = 'seeds/seed_57899/csplit:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/csplit:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @xalloc_die() {
entry:
  call void @cleanup_fatal()
  unreachable
}

define internal void @cleanup_fatal() {
entry:
  call void @cleanup()
  unreachable
}

define internal void @cleanup() {
entry:
  call void @close_output_file(i32 0, ptr null)
  ret void
}

define internal void @close_output_file(i32 %call14, ptr %unlink_ok) {
entry:
  %cmp15 = icmp eq i32 %call14, 0
  %frombool = zext i1 %cmp15 to i8
  store i8 %frombool, ptr %unlink_ok, align 1
  ret void
}
