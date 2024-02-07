target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main(i1 %tobool39, ptr %photometric, i1 %cmp41) {
entry:
  %brmerge = select i1 %tobool39, i1 false, i1 %cmp41
  br i1 %brmerge, label %if.then47, label %if.end51

if.then47:                                        ; preds = %entry
  %0 = load ptr, ptr %photometric, align 8
  br label %if.end51

if.end51:                                         ; preds = %if.then47, %entry
  ret i32 0
}
