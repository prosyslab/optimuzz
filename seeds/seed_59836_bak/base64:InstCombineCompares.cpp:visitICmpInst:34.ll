target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  unreachable

if.then24:                                        ; No predecessors!
  call void @do_decode(ptr null, i1 false)
  unreachable
}

define internal void @do_decode(ptr %k, i1 %tobool33.not) {
entry:
  %.pre.pre = load i32, ptr %k, align 4
  br label %do.body

do.body:                                          ; preds = %for.cond31, %entry
  br label %for.cond31

for.cond31:                                       ; preds = %for.cond31, %do.body
  %add36 = select i1 %tobool33.not, i32 0, i32 2
  %cmp37 = icmp slt i32 %.pre.pre, %add36
  br i1 %cmp37, label %for.cond31, label %do.body
}
