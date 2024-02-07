target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.tm = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, ptr }

define internal i1 @save_abbr(ptr %zone, ptr %0) {
entry:
  %1 = load ptr, ptr %zone, align 8
  %add.ptr = getelementptr %struct.tm, ptr %0, i64 1
  %cmp1 = icmp ult ptr %1, %add.ptr
  br i1 %cmp1, label %common.ret, label %if.end

common.ret:                                       ; preds = %if.end, %entry
  ret i1 false

if.end:                                           ; preds = %entry
  %tobool2 = icmp ne i8 0, 0
  br label %common.ret
}

define i64 @mktime_z() {
entry:
  %call141 = call i1 @save_abbr(ptr null, ptr null)
  ret i64 0
}
