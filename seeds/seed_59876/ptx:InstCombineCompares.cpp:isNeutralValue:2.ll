target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @rpl_re_compile_fastmap() {
entry:
  call void @re_compile_fastmap_iter()
  ret i32 0
}

define internal void @re_compile_fastmap_iter() {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %c.0 = phi i8 [ 0, %entry ], [ %inc109, %do.body ]
  %inc109 = add i8 %c.0, 1
  %cmp111.not = icmp eq i8 %inc109, 0
  br i1 %cmp111.not, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  ret void
}
