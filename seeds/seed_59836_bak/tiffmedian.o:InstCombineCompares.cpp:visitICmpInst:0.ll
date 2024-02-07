target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb16

sw.bb16:                                          ; preds = %sw.bb16, %entry
  br label %sw.bb16

while.end112:                                     ; No predecessors!
  call void @map_colortable()
  ret i32 0
}

define internal void @map_colortable() {
entry:
  br label %for.cond7

for.cond7:                                        ; preds = %for.cond7, %entry
  br label %for.cond7

if.then20:                                        ; No predecessors!
  %call1 = call ptr @create_colorcell(ptr null, i32 0)
  br label %for.cond25

for.cond25:                                       ; preds = %for.cond25, %if.then20
  br label %for.cond25
}

define internal ptr @create_colorcell(ptr %ir, i32 %0) {
entry:
  %cmp11 = icmp ne i32 0, %0
  br i1 %cmp11, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %1 = load i32, ptr %ir, align 4
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  ret ptr null
}
