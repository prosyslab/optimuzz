; ModuleID = 'seeds/seed_57899/bsdcpio:InstCombineCasts.cpp:transformZExtICmp:5.ll'
source_filename = "seeds/seed_57899/bsdcpio:InstCombineCasts.cpp:transformZExtICmp:5.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @__archive_read_register_format(ptr)

define i32 @archive_read_support_format_rar5() {
entry:
  %call10 = call i32 @__archive_read_register_format(ptr nonnull @rar5_read_data)
  ret i32 0
}

define internal i32 @rar5_read_data() {
entry:
  %call25 = call i32 @do_unpack()
  ret i32 0
}

define internal i32 @do_unpack() {
entry:
  %call = call i32 @do_unstore_file()
  ret i32 0
}

define internal i32 @do_unstore_file() {
entry:
  %call = call i32 @advance_multivolume()
  ret i32 0
}

define internal i32 @advance_multivolume() {
entry:
  %call7 = call i32 @skip_base_block()
  ret i32 0
}

define internal i32 @skip_base_block() {
entry:
  %call31 = call i32 @process_base_block(ptr null, i64 0)
  ret i32 0
}

define internal i32 @process_base_block(ptr %header_flags, i64 %0) {
entry:
  %1 = trunc i64 %0 to i8
  %2 = lshr i8 %1, 4
  %3 = and i8 %2, 1
  store i8 %3, ptr %header_flags, align 8
  ret i32 0
}
