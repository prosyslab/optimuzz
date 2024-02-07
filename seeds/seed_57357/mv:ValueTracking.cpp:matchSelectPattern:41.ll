target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @rpl_copy_file_range(i1 %cmp, ptr %p) {
entry:
  %conv20 = select i1 %cmp, i8 1, i8 -1
  store i8 %conv20, ptr %p, align 1
  ret i64 0
}
