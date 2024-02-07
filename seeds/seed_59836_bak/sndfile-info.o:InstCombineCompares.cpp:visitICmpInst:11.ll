target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.SF_BROADCAST_INFO_2K = type { [256 x i8], [32 x i8], [32 x i8], [10 x i8], [8 x i8], i32, i32, i16, [64 x i8], i16, i16, i16, i16, i16, [180 x i8], i32, [2048 x i8] }

define i32 @main() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.then19:                                        ; No predecessors!
  br label %for.cond21

for.cond21:                                       ; preds = %for.cond21, %if.then19
  %call261 = call i32 @broadcast_dump(ptr null, i32 0)
  br label %for.cond21
}

define internal i32 @broadcast_dump(ptr %bext, i32 %conv39) {
entry:
  %cmp40 = icmp sge i32 %conv39, 0
  br i1 %cmp40, label %if.then42, label %if.end45

if.then42:                                        ; preds = %entry
  %umid = getelementptr %struct.SF_BROADCAST_INFO_2K, ptr %bext, i32 0, i32 8
  br label %if.end45

if.end45:                                         ; preds = %if.then42, %entry
  ret i32 0
}
