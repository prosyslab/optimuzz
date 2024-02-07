target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._id3v2_header = type { [3 x i8], [2 x i8], [1 x i8], [4 x i8] }

define i64 @check_for_id3v2_tag(ptr %id3v2hdr, i1 %cmp13, i1 %cmp19) {
entry:
  %or.cond = select i1 %cmp13, i1 false, i1 %cmp19
  br i1 %or.cond, label %if.then33, label %lor.lhs.false21

lor.lhs.false21:                                  ; preds = %entry
  %size22 = getelementptr inbounds %struct._id3v2_header, ptr %id3v2hdr, i32 0, i32 3
  br label %if.then33

if.then33:                                        ; preds = %lor.lhs.false21, %entry
  ret i64 0
}
