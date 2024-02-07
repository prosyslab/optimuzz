target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb14

sw.bb14:                                          ; preds = %sw.bb14, %entry
  br label %sw.bb14

if.then81:                                        ; No predecessors!
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %if.then81
  %call102 = call i1 @digest_check()
  br label %for.cond
}

define internal i1 @digest_check() {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %line_number.0 = phi i64 [ 0, %entry ], [ %inc, %do.body ]
  %inc = add i64 %line_number.0, 1
  %cmp9 = icmp eq i64 %inc, 0
  %0 = xor i1 %cmp9, false
  call void @llvm.assume(i1 %0)
  br label %do.body
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
