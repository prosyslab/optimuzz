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
  %tobool2 = icmp ne i32 %and1, 0
  %lnot = xor i1 %tobool2, true
  %lnot.ext = zext i1 %lnot to i32
  store i32 %lnot.ext, ptr %fp.addr, align 8
  ret i32 0
}
