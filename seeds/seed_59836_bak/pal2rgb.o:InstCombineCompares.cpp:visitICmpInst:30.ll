target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.cpTag = type { i16, i16, i32 }

@tags = external constant [42 x %struct.cpTag]

define i32 @main() {
entry:
  br label %sw.bb16

sw.bb16:                                          ; preds = %sw.bb16, %entry
  br label %sw.bb16

if.end56:                                         ; No predecessors!
  call void @cpTags(ptr null)
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %if.end56
  br label %for.cond
}

define internal void @cpTags(ptr %p) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %cmp = icmp ult ptr %p, getelementptr inbounds ([42 x %struct.cpTag], ptr @tags, i64 1, i64 0)
  br i1 %cmp, label %for.cond, label %for.end

for.end:                                          ; preds = %for.cond
  ret void
}
