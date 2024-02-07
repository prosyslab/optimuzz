target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @nstrftime() {
entry:
  %call1 = call i64 @__strftime_internal(ptr null, ptr null)
  ret i64 0
}

define internal i64 @__strftime_internal(ptr %f, ptr %0) {
entry:
  %add.ptr83 = getelementptr i8, ptr %0, i64 -1
  %cmp84.not = icmp eq ptr %add.ptr83, null
  br i1 %cmp84.not, label %if.end87, label %common.ret

common.ret:                                       ; preds = %if.end87, %entry
  ret i64 0

if.end87:                                         ; preds = %entry
  store i64 0, ptr %f, align 8
  br label %common.ret
}
