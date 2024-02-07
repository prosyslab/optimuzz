target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.end251:                                        ; No predecessors!
  %call2551 = call i64 @io_blksize(ptr null, i64 0)
  unreachable
}

define internal i64 @io_blksize(ptr %sb, i64 %0) {
entry:
  %cmp24 = icmp ule i64 %0, 9223372036854775807
  br i1 %cmp24, label %if.then25, label %if.end

if.then25:                                        ; preds = %entry
  %1 = load i64, ptr %sb, align 8
  br label %if.end

if.end:                                           ; preds = %if.then25, %entry
  ret i64 0
}
