target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @mgetgroups(ptr %g, ptr %0, i64 %idx.ext77) {
entry:
  %add.ptr78 = getelementptr i32, ptr %0, i64 %idx.ext77
  store ptr %add.ptr78, ptr %g, align 8
  %1 = load ptr, ptr %g, align 8
  %cmp80 = icmp ult ptr null, %1
  br i1 %cmp80, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret i32 0

for.body:                                         ; preds = %entry
  %2 = load ptr, ptr %g, align 8
  br label %common.ret
}
