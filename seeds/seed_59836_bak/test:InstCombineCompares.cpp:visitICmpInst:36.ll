target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal ptr @quotearg_n_options(ptr %sv) {
entry:
  %cmp4 = icmp eq ptr %sv, null
  %frombool = zext i1 %cmp4 to i8
  store i8 %frombool, ptr %sv, align 1
  ret ptr null
}

define ptr @quote_n_mem() {
entry:
  %call1 = call ptr @quotearg_n_options(ptr null)
  ret ptr null
}
