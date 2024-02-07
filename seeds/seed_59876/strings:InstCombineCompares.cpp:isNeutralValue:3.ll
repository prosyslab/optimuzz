target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @bfd_set_error()

define i64 @bfd_elf64_slurp_symbol_table(ptr %amt) {
entry:
  %0 = load i64, ptr %amt, align 8
  %mul = mul i64 %0, 96
  %div37 = udiv i64 %mul, 96
  %cmp38 = icmp ne i64 %div37, %0
  br i1 %cmp38, label %if.then39, label %common.ret

common.ret:                                       ; preds = %if.then39, %entry
  ret i64 0

if.then39:                                        ; preds = %entry
  call void @bfd_set_error()
  br label %common.ret
}
