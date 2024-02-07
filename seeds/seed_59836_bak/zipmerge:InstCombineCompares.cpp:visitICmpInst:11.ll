target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb

sw.bb:                                            ; preds = %sw.bb, %entry
  br label %sw.bb

if.end33:                                         ; No predecessors!
  %call381 = call ptr @merge_zip(i64 0, ptr null)
  unreachable
}

define internal ptr @merge_zip(i64 %call11, ptr %za.addr) {
entry:
  %cmp12 = icmp sge i64 %call11, 0
  br i1 %cmp12, label %if.then13, label %common.ret

common.ret:                                       ; preds = %if.then13, %entry
  ret ptr null

if.then13:                                        ; preds = %entry
  %0 = load ptr, ptr %za.addr, align 8
  br label %common.ret
}
