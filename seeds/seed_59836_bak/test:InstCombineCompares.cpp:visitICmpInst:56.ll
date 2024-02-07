target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal ptr @quotearg_n_options(ptr %preallocated, i8 %0) {
entry:
  %tobool.not = icmp eq i8 %0, 0
  %cond = select i1 %tobool.not, ptr %preallocated, ptr null
  %call8 = load volatile ptr, ptr %cond, align 8
  ret ptr null
}

define ptr @quote_n_mem() {
entry:
  %call1 = call ptr @quotearg_n_options(ptr null, i8 0)
  ret ptr null
}
