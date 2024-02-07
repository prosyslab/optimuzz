target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

define void @sha512_process_bytes(ptr %buffer.addr, ptr %0, i64 %1) {
entry:
  %buffer.addr1 = alloca ptr, align 8
  br label %if.end24

if.end24:                                         ; preds = %entry
  br label %if.then26

if.then26:                                        ; preds = %if.end24
  %2 = load ptr, ptr %buffer.addr, align 8
  %3 = ptrtoint ptr %buffer.addr to i64
  %rem = urem i64 %1, 8
  %cmp27 = icmp ne i64 %rem, 0
  br i1 %cmp27, label %if.then28, label %if.else

if.then28:                                        ; preds = %if.then26
  ret void

if.else:                                          ; preds = %if.then26
  %4 = load ptr, ptr undef, align 8
  ret void
}

attributes #0 = { argmemonly nofree nounwind willreturn }
