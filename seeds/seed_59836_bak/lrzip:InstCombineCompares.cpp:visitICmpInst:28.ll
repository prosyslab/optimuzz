target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @LzmaDec_DecodeToDic() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.end61:                                         ; No predecessors!
  %call64 = call i32 @LzmaDec_DecodeReal2()
  ret i32 0
}

define internal i32 @LzmaDec_DecodeReal2() {
entry:
  %call1 = call i32 @LzmaDec_DecodeReal(ptr null)
  ret i32 0
}

define internal i32 @LzmaDec_DecodeReal(ptr %0) {
entry:
  br label %do.body977

do.body977:                                       ; preds = %do.body977, %entry
  %incdec.ptr980 = getelementptr i8, ptr %0, i64 1
  %cmp981.not = icmp eq ptr %incdec.ptr980, null
  br i1 %cmp981.not, label %do.end983, label %do.body977

do.end983:                                        ; preds = %do.body977
  ret i32 0
}
