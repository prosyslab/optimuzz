target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i32 @fprintf(ptr, ptr, ...)

define void @cmdusage(ptr %fmtinfo, i32 %0) {
entry:
  %tobool11.not = icmp eq i32 %0, 0
  %cond = select i1 %tobool11.not, ptr null, ptr %fmtinfo
  %call12 = call i32 (ptr, ptr, ...) @fprintf(ptr null, ptr null, ptr %cond, ptr null, ptr null)
  ret void
}
