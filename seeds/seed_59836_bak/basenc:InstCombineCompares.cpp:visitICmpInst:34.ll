target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb

sw.bb:                                            ; preds = %sw.bb, %entry
  br label %sw.bb

if.then36:                                        ; No predecessors!
  call void @do_decode(ptr null, i1 false)
  unreachable
}

define internal void @do_decode(ptr %k, i1 %tobool43.not) {
entry:
  %.pre.pre = load i32, ptr %k, align 4
  br label %do.body

do.body:                                          ; preds = %for.cond41, %entry
  br label %for.cond41

for.cond41:                                       ; preds = %for.cond41, %do.body
  %add46 = select i1 %tobool43.not, i32 0, i32 2
  %cmp47 = icmp slt i32 %.pre.pre, %add46
  br i1 %cmp47, label %for.cond41, label %do.body
}
