target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, ptr, ptr }

define void @archive_string_vsprintf(ptr %0, i32 %gp_offset) {
entry:
  %fits_in_gp = icmp ule i32 %gp_offset, 0
  br i1 %fits_in_gp, label %vaarg.in_reg, label %common.ret

common.ret:                                       ; preds = %vaarg.in_reg, %entry
  ret void

vaarg.in_reg:                                     ; preds = %entry
  %1 = getelementptr %struct.__va_list_tag, ptr %0, i32 0, i32 3
  br label %common.ret
}
