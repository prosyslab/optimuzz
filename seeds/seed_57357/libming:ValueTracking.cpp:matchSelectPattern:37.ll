target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @Ming_useSWFVersion(i32 %0) {
entry:
  %cmp = icmp slt i32 %0, 0
  %or.cond = select i1 %cmp, i1 false, i1 true
  br i1 %or.cond, label %do.body, label %if.end3

do.body:                                          ; preds = %entry
  %tobool = icmp ne ptr null, null
  br label %if.end3

if.end3:                                          ; preds = %do.body, %entry
  ret void
}
