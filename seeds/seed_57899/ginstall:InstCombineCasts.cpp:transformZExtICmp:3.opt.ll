; ModuleID = 'seeds/seed_57899/ginstall:InstCombineCasts.cpp:transformZExtICmp:3.ll'
source_filename = "seeds/seed_57899/ginstall:InstCombineCasts.cpp:transformZExtICmp:3.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i1 @set_process_security_ctx(ptr %x.addr, i8 %0) {
entry:
  %1 = and i8 %0, 1
  store i8 %1, ptr %x.addr, align 1
  ret i1 false
}
