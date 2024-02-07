target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, ptr, ptr }

define void @st_warning(i32 %0, ptr %args, ...) {
entry:
  %tobool = icmp ne i32 %0, 0
  %or.cond = select i1 %tobool, i1 false, i1 true
  br i1 %or.cond, label %common.ret, label %if.end

common.ret:                                       ; preds = %if.end, %entry
  ret void

if.end:                                           ; preds = %entry
  %arraydecay = getelementptr [1 x %struct.__va_list_tag], ptr %args, i64 0, i64 0
  br label %common.ret
}
