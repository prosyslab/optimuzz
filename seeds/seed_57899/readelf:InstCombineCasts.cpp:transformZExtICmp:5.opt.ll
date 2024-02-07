; ModuleID = 'seeds/seed_57899/readelf:InstCombineCasts.cpp:transformZExtICmp:5.ll'
source_filename = "seeds/seed_57899/readelf:InstCombineCasts.cpp:transformZExtICmp:5.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @cplus_demangle_mangled_name() {
entry:
  %call = call ptr @d_encoding()
  ret ptr null
}

define internal ptr @d_encoding() {
entry:
  %call5 = call ptr @d_name()
  ret ptr null
}

define internal ptr @d_name() {
if.then15:
  %call161 = call ptr @d_substitution(ptr null, i32 0)
  ret ptr null
}

define internal ptr @d_substitution(ptr %di.addr, i32 %0) {
entry:
  %and = lshr i32 %0, 3
  %and.lobit = and i32 %and, 1
  store i32 %and.lobit, ptr %di.addr, align 4
  ret ptr null
}
