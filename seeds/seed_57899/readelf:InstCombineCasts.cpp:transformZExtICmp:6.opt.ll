; ModuleID = 'seeds/seed_57899/readelf:InstCombineCasts.cpp:transformZExtICmp:6.ll'
source_filename = "seeds/seed_57899/readelf:InstCombineCasts.cpp:transformZExtICmp:6.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ctf_serialize() {
entry:
  %call151 = call i32 @ctf_symtypetab_sect_sizes(ptr null, i32 0)
  ret i32 0
}

define internal i32 @ctf_symtypetab_sect_sizes(ptr %fp.addr, i32 %0) {
entry:
  %and1 = and i32 %0, 1
  %1 = xor i32 %and1, 1
  store i32 %1, ptr %fp.addr, align 8
  ret i32 0
}
