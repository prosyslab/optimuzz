target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @pngx_read_bmp() {
entry:
  ret i32 0

if.end332:                                        ; No predecessors!
  %call3511 = call i64 @bmp_read_rows(ptr null, ptr null, ptr null, i64 0)
  unreachable
}

define internal i64 @bmp_read_rows(ptr %inc, ptr %crt_row, ptr %0, i64 %idx.ext41) {
entry:
  %add.ptr42 = getelementptr ptr, ptr %0, i64 %idx.ext41
  store ptr %add.ptr42, ptr %crt_row, align 8
  %1 = load ptr, ptr %crt_row, align 8
  %cmp44 = icmp eq ptr %1, null
  br i1 %cmp44, label %if.then45, label %common.ret

common.ret:                                       ; preds = %if.then45, %entry
  ret i64 0

if.then45:                                        ; preds = %entry
  %2 = load ptr, ptr %inc, align 8
  br label %common.ret
}
