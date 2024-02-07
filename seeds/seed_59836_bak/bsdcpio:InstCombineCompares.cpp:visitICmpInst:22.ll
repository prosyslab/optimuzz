target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.archive_read_filter_bidder = type { ptr, ptr, ptr }

@program_reader_vtable = internal constant %struct.archive_read_filter_bidder { ptr @program_filter_read, ptr null, ptr null }

define i32 @__archive_read_program(ptr %vtable) {
entry:
  br label %return

if.end30:                                         ; No predecessors!
  store ptr @program_reader_vtable, ptr %vtable, align 8
  br label %return

return:                                           ; preds = %if.end30, %entry
  ret i32 0
}

define internal i64 @program_filter_read() {
entry:
  %call1 = call i64 @child_read(ptr null, i64 0)
  ret i64 0
}

define internal i64 @child_read(ptr %buf_len.addr, i64 %0) {
entry:
  %cmp = icmp ugt i64 %0, 9223372036854775807
  br i1 %cmp, label %common.ret, label %cond.false

common.ret:                                       ; preds = %cond.false, %entry
  ret i64 0

cond.false:                                       ; preds = %entry
  %1 = load i64, ptr %buf_len.addr, align 8
  br label %common.ret
}
