target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @build_cmdline() {
entry:
  %call1 = call i32 @cmdline_length(ptr null, i32 0)
  ret void
}

define internal i32 @cmdline_length(ptr %argcnt, i32 %0) {
entry:
  %cmp1 = icmp ult i32 0, %0
  br i1 %cmp1, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret i32 0

for.body:                                         ; preds = %entry
  store i8 0, ptr %argcnt, align 1
  br label %common.ret
}
