target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.transport_info = type { ptr, ptr }

define internal ptr @find_cell(ptr %c, ptr %0) {
entry:
  %1 = load ptr, ptr %c, align 8
  %add.ptr7 = getelementptr %struct.transport_info, ptr %0, i64 -1
  %cmp8 = icmp ne ptr %1, %add.ptr7
  br i1 %cmp8, label %cond.true, label %common.ret

common.ret:                                       ; preds = %cond.true, %entry
  ret ptr null

cond.true:                                        ; preds = %entry
  %2 = load ptr, ptr %c, align 8
  br label %common.ret
}

define i32 @hash_table_contains() {
entry:
  %call1 = call ptr @find_cell(ptr null, ptr null)
  ret i32 0
}
