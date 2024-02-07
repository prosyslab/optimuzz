; ModuleID = 'seeds/seed_57899/printf:InstCombineCasts.cpp:transformZExtICmp:7.ll'
source_filename = "seeds/seed_57899/printf:InstCombineCasts.cpp:transformZExtICmp:7.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i64 @quotearg_buffer_restyled(ptr %printable, i8 %0) {
entry:
  %1 = and i8 %0, 1
  store i8 %1, ptr %printable, align 1
  ret i64 0
}

define internal ptr @quotearg_n_options() {
entry:
  %call211 = call i64 @quotearg_buffer_restyled(ptr null, i8 0)
  ret ptr null
}

define ptr @quote_n_mem() {
entry:
  %call = call ptr @quotearg_n_options()
  ret ptr null
}
