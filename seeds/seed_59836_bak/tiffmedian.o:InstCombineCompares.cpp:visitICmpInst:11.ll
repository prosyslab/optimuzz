target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb15

sw.bb15:                                          ; preds = %sw.bb15, %entry
  br label %sw.bb15

if.then93:                                        ; No predecessors!
  call void @get_histogram(i32 0, ptr null)
  br label %while.cond103

while.cond103:                                    ; preds = %while.cond103, %if.then93
  br label %while.cond103
}

define internal void @get_histogram(i32 %call7, ptr %inputline) {
entry:
  %cmp8 = icmp sle i32 %call7, 0
  br i1 %cmp8, label %common.ret, label %if.end10

common.ret:                                       ; preds = %if.end10, %entry
  ret void

if.end10:                                         ; preds = %entry
  %0 = load ptr, ptr %inputline, align 8
  br label %common.ret
}
