target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @appimage2_size() {
entry:
  %call151 = call i64 @read_elf32(ptr null)
  ret i64 0
}

define internal i64 @read_elf32(ptr %retval) {
entry:
  %sht_end = alloca i64, align 8
  %last_section_end = alloca i64, align 8
  %0 = load i64, ptr %sht_end, align 8
  %1 = load i64, ptr %last_section_end, align 8
  %cmp26 = icmp ugt i64 %0, %1
  %2 = load i64, ptr %sht_end, align 8
  %3 = load i64, ptr %last_section_end, align 8
  %cond = select i1 %cmp26, i64 %2, i64 %3
  store i64 %cond, ptr %retval, align 8
  ret i64 0
}
