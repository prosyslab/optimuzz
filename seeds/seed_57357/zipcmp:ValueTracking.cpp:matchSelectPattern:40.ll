target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @diff_output_file(ptr %name.addr, i32 %conv7) {
entry:
  %cmp8 = icmp eq i32 %conv7, 0
  br i1 %cmp8, label %if.then10, label %if.else

if.then10:                                        ; preds = %entry
  %0 = load i8, ptr %name.addr, align 1
  br label %if.else

if.else:                                          ; preds = %if.then10, %entry
  ret void
}
