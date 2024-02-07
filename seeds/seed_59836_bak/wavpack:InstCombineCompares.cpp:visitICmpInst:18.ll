target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.RiffChunkHeader = type { [4 x i8], i32, [4 x i8] }

define i32 @ParseAiffHeaderConfig(i1 %tobool2, i64 %conv, ptr %aiff_chunk_header) {
entry:
  %cmp3 = icmp ne i64 %conv, 0
  %or.cond = select i1 %tobool2, i1 false, i1 %cmp3
  br i1 %or.cond, label %if.then13, label %lor.lhs.false5

lor.lhs.false5:                                   ; preds = %entry
  %formType = getelementptr %struct.RiffChunkHeader, ptr %aiff_chunk_header, i32 0, i32 2
  br label %if.then13

if.then13:                                        ; preds = %lor.lhs.false5, %entry
  ret i32 0
}
