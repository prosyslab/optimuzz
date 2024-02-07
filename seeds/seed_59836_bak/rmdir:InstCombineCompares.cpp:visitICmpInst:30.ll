target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.arguments = type { i64, ptr, [7 x %struct.argument] }
%struct.argument = type { i32, %union.anon.5 }
%union.anon.5 = type { x86_fp80 }

define i32 @printf_parse(ptr %a.addr, ptr %0) {
entry:
  %1 = load ptr, ptr %a.addr, align 8
  %direct_alloc_arg234 = getelementptr %struct.arguments, ptr %0, i32 0, i32 2
  %cmp236 = icmp ne ptr %1, %direct_alloc_arg234
  br i1 %cmp236, label %cond.true238, label %common.ret

common.ret:                                       ; preds = %cond.true238, %entry
  ret i32 0

cond.true238:                                     ; preds = %entry
  %2 = load ptr, ptr %a.addr, align 8
  br label %common.ret
}
