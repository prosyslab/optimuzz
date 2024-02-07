target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call10 = call i32 @compare()
  ret i32 0
}

define internal i32 @compare() {
entry:
  br label %out

if.then10:                                        ; No predecessors!
  %call111 = call i32 @comparison_error(i64 0, ptr null)
  br label %out

out:                                              ; preds = %if.then10, %entry
  ret i32 0
}

define internal i32 @comparison_error(i64 %0, ptr %buffer) {
entry:
  %cmp = icmp sge i64 %0, 0
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %arraydecay = getelementptr [128 x i8], ptr %buffer, i64 0, i64 0
  br label %common.ret
}
