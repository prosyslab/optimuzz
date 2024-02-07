target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @rpl_fts_read() {
entry:
  %call1091 = call ptr @fts_build(i1 false)
  ret ptr null
}

define internal ptr @fts_build(i1 %cmp18) {
entry:
  %cond26 = select i1 %cmp18, i32 131072, i32 0
  %call27 = call ptr @opendirat(i32 %cond26)
  ret ptr null
}

declare ptr @opendirat(i32)
