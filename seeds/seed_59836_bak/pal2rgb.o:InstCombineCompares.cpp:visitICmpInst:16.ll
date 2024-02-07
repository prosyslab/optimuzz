target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb14

sw.bb14:                                          ; preds = %sw.bb14, %entry
  br label %sw.bb14

if.then62:                                        ; No predecessors!
  %call981 = call i32 @checkcmap(ptr null, i16 0)
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %if.then62
  br label %for.cond
}

define internal i32 @checkcmap(ptr %r.addr, i16 %0) {
entry:
  %conv = zext i16 %0 to i32
  %cmp1 = icmp sge i32 %conv, 1
  br i1 %cmp1, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %1 = load ptr, ptr %r.addr, align 8
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  ret i32 0
}
