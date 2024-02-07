target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @__archive_read_register_format(ptr)

define i32 @archive_read_support_format_rar5() {
entry:
  %call10 = call i32 @__archive_read_register_format(ptr @rar5_read_data)
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
  %call31 = call i32 @process_base_block(ptr null, i1 false, i1 false)
  ret i32 0
}

define internal i32 @process_base_block(ptr %raw_hdr_size, i1 %cmp13, i1 %cmp14) {
entry:
  %or.cond = select i1 %cmp13, i1 false, i1 %cmp14
  br i1 %or.cond, label %if.then17, label %lor.lhs.false15

lor.lhs.false15:                                  ; preds = %entry
  %0 = load i64, ptr %raw_hdr_size, align 8
  br label %if.then17

if.then17:                                        ; preds = %lor.lhs.false15, %entry
  ret i32 0
}
