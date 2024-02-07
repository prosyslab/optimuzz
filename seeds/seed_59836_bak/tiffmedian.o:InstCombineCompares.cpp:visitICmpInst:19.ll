target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb16

sw.bb16:                                          ; preds = %sw.bb16, %entry
  br label %sw.bb16

if.then148:                                       ; No predecessors!
  call void @quant_fsdither(ptr null)
  br label %for.cond243

for.cond243:                                      ; preds = %for.cond243, %if.then148
  br label %for.cond243
}

define internal void @quant_fsdither(ptr %r2) {
entry:
  %0 = load i32, ptr %r2, align 4
  %cmp68 = icmp sgt i32 %0, 0
  %spec.store.select = select i1 %cmp68, i32 0, i32 %0
  store i32 %spec.store.select, ptr %r2, align 4
  ret void
}
