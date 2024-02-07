target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.end:                                           ; preds = %if.end
  %call15 = call i1 @print_factors()
  br label %if.end
}

define internal i1 @print_factors() {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  br label %while.cond

while.end:                                        ; No predecessors!
  switch i32 0, label %return [
    i32 0, label %return
    i32 1, label %sw.epilog
  ]

sw.epilog:                                        ; preds = %while.end
  call void @mp_factor(i1 false, ptr null, i32 0)
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %sw.epilog
  br label %for.cond

return:                                           ; preds = %while.end, %while.end
  ret i1 false
}

define internal void @mp_factor(i1 %cmp, ptr %t.addr, i32 %0) {
entry:
  br i1 %cmp, label %cond.end, label %cond.false

cond.false:                                       ; preds = %entry
  %1 = load ptr, ptr %t.addr, align 8
  %cmp24 = icmp sgt i32 %0, 0
  %conv = zext i1 %cmp24 to i32
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %entry
  %cond = phi i32 [ %conv, %cond.false ], [ 0, %entry ]
  %cmp3 = icmp ne i32 %cond, 0
  br i1 %cmp3, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %cond.end
  ret void

if.then:                                          ; preds = %cond.end
  %2 = load ptr, ptr %t.addr, align 8
  br label %common.ret
}
