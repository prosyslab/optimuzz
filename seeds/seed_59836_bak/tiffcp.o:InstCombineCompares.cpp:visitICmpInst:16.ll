target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.end151:                                        ; No predecessors!
  br label %for.cond152

for.cond152:                                      ; preds = %for.cond152, %if.end151
  %call1531 = call i32 @tiffcp(ptr null, i16 0)
  br label %for.cond152
}

define internal i32 @tiffcp(ptr %samplesperpixel, i16 %0) {
entry:
  %conv179 = zext i16 %0 to i32
  %cmp180 = icmp sle i32 %conv179, 0
  br i1 %cmp180, label %if.then182, label %if.end183

if.then182:                                       ; preds = %entry
  %1 = load ptr, ptr %samplesperpixel, align 8
  br label %if.end183

if.end183:                                        ; preds = %if.then182, %entry
  ret i32 0
}
