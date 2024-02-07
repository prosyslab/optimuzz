target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb1

sw.bb1:                                           ; preds = %sw.bb1, %entry
  br label %sw.bb1

if.then:                                          ; No predecessors!
  %call221 = call ptr @read_from_file(ptr null, i64 0)
  ret i32 0
}

define internal ptr @read_from_file(ptr %length.addr, i64 %0) {
entry:
  %cmp11 = icmp ugt i64 %0, 9223372036854775807
  br i1 %cmp11, label %if.then12, label %common.ret

common.ret:                                       ; preds = %if.then12, %entry
  ret ptr null

if.then12:                                        ; preds = %entry
  %1 = load ptr, ptr %length.addr, align 8
  br label %common.ret
}
