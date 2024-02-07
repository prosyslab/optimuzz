target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.timespec = type { i64, i64 }

define i32 @main() {
entry:
  unreachable

if.end251:                                        ; No predecessors!
  %call2551 = call i64 @io_blksize(ptr null, i64 0, i1 false)
  unreachable
}

define internal i64 @io_blksize(ptr %sb, i64 %0, i1 %cmp2) {
entry:
  %cond = select i1 %cmp2, i64 %0, i64 0
  %cmp4 = icmp sle i64 %cond, 0
  br i1 %cmp4, label %common.ret, label %cond.false6

common.ret:                                       ; preds = %cond.false6, %entry
  ret i64 0

cond.false6:                                      ; preds = %entry
  %st_blksize7 = getelementptr %struct.stat, ptr %sb, i32 0, i32 9
  br label %common.ret
}
