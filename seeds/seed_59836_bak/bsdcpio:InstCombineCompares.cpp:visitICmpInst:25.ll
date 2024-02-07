target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @__archive_read_filter_consume() {
entry:
  br label %return

if.end3:                                          ; No predecessors!
  %call1 = call i64 @advance_file_pointer(ptr null, i64 0)
  br label %return

return:                                           ; preds = %if.end3, %entry
  ret i64 0
}

define internal i64 @advance_file_pointer(ptr %bytes_skipped, i64 %0) {
entry:
  %sub38 = sub i64 1, %0
  %cmp39 = icmp eq i64 %sub38, 0
  br i1 %cmp39, label %if.then40, label %common.ret

common.ret:                                       ; preds = %if.then40, %entry
  ret i64 0

if.then40:                                        ; preds = %entry
  %1 = load i64, ptr %bytes_skipped, align 8
  br label %common.ret
}
