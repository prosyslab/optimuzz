target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @getfileconat(ptr %proc_file) {
entry:
  %proc_buf = alloca [4032 x i8], align 16
  %0 = load ptr, ptr %proc_file, align 8
  %cmp8 = icmp ne ptr %0, %proc_buf
  br i1 %cmp8, label %if.then10, label %if.end11

if.then10:                                        ; preds = %entry
  %1 = load ptr, ptr %proc_file, align 8
  br label %if.end11

if.end11:                                         ; preds = %if.then10, %entry
  ret i32 0
}
