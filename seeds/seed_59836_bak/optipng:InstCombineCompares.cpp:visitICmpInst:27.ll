target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@extra_lbits = internal constant [29 x i32] [i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 2, i32 2, i32 2, i32 2, i32 3, i32 3, i32 3, i32 3, i32 4, i32 4, i32 4, i32 4, i32 5, i32 5, i32 5, i32 5, i32 0]

define void @_tr_flush_block() {
entry:
  br label %if.end128

if.then24:                                        ; No predecessors!
  call void @compress_block(ptr null, i64 0)
  br label %if.end128

if.end128:                                        ; preds = %if.then24, %entry
  ret void
}

define internal void @compress_block(ptr %code, i64 %idxprom127) {
entry:
  %arrayidx128 = getelementptr [29 x i32], ptr @extra_lbits, i64 0, i64 %idxprom127
  %0 = load i32, ptr %arrayidx128, align 4
  store i32 %0, ptr %code, align 4
  %1 = load i32, ptr %code, align 4
  %cmp129 = icmp ne i32 %1, 0
  br i1 %cmp129, label %if.then131, label %common.ret

common.ret:                                       ; preds = %if.then131, %entry
  ret void

if.then131:                                       ; preds = %entry
  %2 = load i32, ptr %code, align 4
  br label %common.ret
}
