target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @read_color_map(ptr %cinfo, i1 %cmp.i, i1 %cmp4.i15) {
entry:
  %or.cond56.i = select i1 %cmp4.i15, i1 false, i1 %cmp.i
  br i1 %or.cond56.i, label %if.then.i19, label %sw.epilog.sink.split

if.then.i19:                                      ; preds = %entry
  %0 = load ptr, ptr %cinfo, align 8
  br label %sw.epilog.sink.split

sw.epilog.sink.split:                             ; preds = %if.then.i19, %entry
  ret void
}
