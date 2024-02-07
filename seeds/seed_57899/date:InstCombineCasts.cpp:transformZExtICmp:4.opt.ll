; ModuleID = 'seeds/seed_57899/date:InstCombineCasts.cpp:transformZExtICmp:4.ll'
source_filename = "seeds/seed_57899/date:InstCombineCasts.cpp:transformZExtICmp:4.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @nstrftime() {
entry:
  %call1 = call i64 @__strftime_internal.391(ptr null, i8 0)
  ret i64 0
}

define internal i64 @__strftime_internal.391(ptr %upcase.addr, i8 %0) {
entry:
  %1 = and i8 %0, 1
  store i8 %1, ptr %upcase.addr, align 1
  ret i64 0
}
