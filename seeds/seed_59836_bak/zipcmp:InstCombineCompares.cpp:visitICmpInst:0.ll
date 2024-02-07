target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb

sw.bb:                                            ; preds = %sw.bb, %entry
  br label %sw.bb

if.end:                                           ; No predecessors!
  %call16 = call i32 @compare_zip()
  unreachable
}

define internal i32 @compare_zip() {
entry:
  %call261 = call i32 @list_zip(ptr null, i64 0)
  ret i32 0
}

define internal i32 @list_zip(ptr %a.addr, i64 %0) {
entry:
  %cmp19 = icmp ult i64 0, %0
  br i1 %cmp19, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret i32 0

for.body:                                         ; preds = %entry
  %1 = load ptr, ptr %a.addr, align 8
  br label %common.ret
}
