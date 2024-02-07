target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @archive_read_support_format_zip_streamable() {
entry:
  br label %return

if.end:                                           ; No predecessors!
  %call5 = load i32, ptr @archive_read_format_zip_read_data, align 4
  br label %return

return:                                           ; preds = %if.end, %entry
  ret i32 0
}

define internal i32 @archive_read_format_zip_read_data() {
entry:
  %a.addr = alloca ptr, align 8
  %zip = alloca ptr, align 8
  %0 = load i64, ptr %zip, align 8
  %and76 = and i64 %0, 1
  %1 = load i64, ptr %zip, align 8
  %and78 = and i64 %1, 1
  %cmp79 = icmp ne i64 %and76, %and78
  br i1 %cmp79, label %if.then81, label %common.ret

common.ret:                                       ; preds = %if.then81, %entry
  ret i32 0

if.then81:                                        ; preds = %entry
  %2 = load ptr, ptr %a.addr, align 8
  br label %common.ret
}
