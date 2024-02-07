target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @LzmaDec_DecodeToDic() {
entry:
  %call1 = call i32 @LzmaDec_TryDummy(ptr null, i32 0, ptr null)
  ret i32 0
}

define internal i32 @LzmaDec_TryDummy(ptr %range, i32 %0, ptr %add.ptr389) {
entry:
  %cmp390 = icmp ult i32 %0, 4
  %cond395 = select i1 %cmp390, i32 %0, i32 3
  %idx.ext397 = zext i32 %cond395 to i64
  %add.ptr398 = getelementptr inbounds i16, ptr %add.ptr389, i64 %idx.ext397
  store ptr %add.ptr398, ptr %range, align 8
  ret i32 0
}
