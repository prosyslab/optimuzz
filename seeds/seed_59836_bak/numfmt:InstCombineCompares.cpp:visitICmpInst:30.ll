target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.then99:                                        ; No predecessors!
  call void @parse_format_string(ptr null, ptr null, i64 0)
  unreachable
}

define internal void @parse_format_string(ptr %endptr, ptr %0, i64 %1) {
entry:
  %2 = load ptr, ptr %endptr, align 8
  %add.ptr48 = getelementptr i8, ptr %0, i64 %1
  %cmp49 = icmp ne ptr %2, %add.ptr48
  br i1 %cmp49, label %land.lhs.true, label %common.ret

common.ret:                                       ; preds = %land.lhs.true, %entry
  ret void

land.lhs.true:                                    ; preds = %entry
  %3 = load i64, ptr %endptr, align 8
  br label %common.ret
}
