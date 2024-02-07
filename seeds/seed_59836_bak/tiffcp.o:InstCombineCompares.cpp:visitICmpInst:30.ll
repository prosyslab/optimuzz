target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.cpTag = type { i16, i16, i32 }

@tags = external constant [33 x %struct.cpTag]

define i32 @main() {
entry:
  br label %sw.bb

sw.bb:                                            ; preds = %sw.bb, %entry
  br label %sw.bb

if.end151:                                        ; No predecessors!
  br label %for.cond152

for.cond152:                                      ; preds = %for.cond152, %if.end151
  %call1531 = call i32 @tiffcp(ptr null)
  br label %for.cond152
}

define internal i32 @tiffcp(ptr %p) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %cmp390 = icmp ult ptr %p, getelementptr inbounds ([33 x %struct.cpTag], ptr @tags, i64 1, i64 0)
  br i1 %cmp390, label %for.cond, label %for.end

for.end:                                          ; preds = %for.cond
  ret i32 0
}
