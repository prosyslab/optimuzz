target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.timespec = type { i64, i64 }

define i32 @main() {
entry:
  unreachable

for.inc:                                          ; preds = %for.inc
  %call50 = call i1 @wipefd()
  br label %for.inc
}

define internal i1 @wipefd() {
entry:
  br label %return

if.end5:                                          ; No predecessors!
  %call61 = call i1 @do_wipefd(ptr null, i64 0, i1 false)
  br label %return

return:                                           ; preds = %if.end5, %entry
  ret i1 false
}

define internal i1 @do_wipefd(ptr %st, i64 %0, i1 %cmp116) {
entry:
  %cond122 = select i1 %cmp116, i64 0, i64 512
  %cmp123 = icmp slt i64 %cond122, %0
  br i1 %cmp123, label %cond.true125, label %common.ret

common.ret:                                       ; preds = %cond.true125, %entry
  ret i1 false

cond.true125:                                     ; preds = %entry
  %st_blksize126 = getelementptr %struct.stat, ptr %st, i32 0, i32 9
  br label %common.ret
}
