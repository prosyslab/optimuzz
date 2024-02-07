; ModuleID = 'seeds/seed_57899/firejail:InstCombineCasts.cpp:transformZExtICmp:0.ll'
source_filename = "seeds/seed_57899/firejail:InstCombineCasts.cpp:transformZExtICmp:0.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @dbus_check_name() {
entry:
  %call1 = call i32 @check_bus_or_interface_name(ptr null, i32 0)
  ret i32 0
}

define internal i32 @check_bus_or_interface_name(ptr %p, i32 %conv17) {
entry:
  %conv17.lobit = lshr i32 %conv17, 31
  store i32 %conv17.lobit, ptr %p, align 4
  ret i32 0
}
