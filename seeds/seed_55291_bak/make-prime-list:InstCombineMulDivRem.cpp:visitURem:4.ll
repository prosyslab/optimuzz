target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.14 = external dso_local constant [8 x i8]

define i32 @main() {
for.end33:
  call void @output_primes()
  ret i32 0
}

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #0

define internal void @output_primes() {
if.end:
  call void @print_wide_uint(ptr undef, i32 undef, ptr undef, i32 undef, i32 undef, i32 undef, ptr undef, i32 undef)
  ret void
}

declare i32 @printf(ptr, ...)

define internal void @print_wide_uint(ptr %wide_uint_bits.addr, i32 %0, ptr %bits_per_literal, i32 %sub20, i32 %1, i32 %rem, ptr %hex_digits_per_literal, i32 %2) {
entry:
  %wide_uint_bits.addr1 = alloca i32, align 4
  %hex_digits_per_literal2 = alloca i32, align 4
  %bits_per_literal3 = alloca i32, align 4
  br label %if.else

if.else:                                          ; preds = %entry
  br i1 true, label %if.then18, label %if.end23

if.then18:                                        ; preds = %if.else
  %3 = load i32, ptr %wide_uint_bits.addr, align 4
  %sub204 = sub i32 %0, 0
  %4 = load i32, ptr %wide_uint_bits.addr, align 4
  %rem5 = urem i32 %0, %0
  %rem21 = urem i32 %0, 4
  %add22 = add i32 4, 0
  store i32 %rem21, ptr %wide_uint_bits.addr, align 4
  br label %if.end23

if.end23:                                         ; preds = %if.then18, %if.else
  br label %if.end24

if.end24:                                         ; preds = %if.end23
  %5 = load i32, ptr %wide_uint_bits.addr, align 4
  %call25 = call i32 (ptr, ...) @printf(ptr null, i32 %0, i32 0)
  ret void
}

attributes #0 = { argmemonly nofree nounwind willreturn writeonly }
