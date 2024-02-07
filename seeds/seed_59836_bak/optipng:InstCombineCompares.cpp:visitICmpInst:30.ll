target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_do_write_interlace(ptr %row.addr, ptr %0, i64 %mul) {
entry:
  %add.ptr129 = getelementptr i8, ptr %0, i64 %mul
  %1 = load ptr, ptr %row.addr, align 8
  %cmp130 = icmp ne ptr %1, %add.ptr129
  br i1 %cmp130, label %if.then132, label %if.end133

if.then132:                                       ; preds = %entry
  %2 = load ptr, ptr %row.addr, align 8
  br label %if.end133

if.end133:                                        ; preds = %if.then132, %entry
  ret void
}
