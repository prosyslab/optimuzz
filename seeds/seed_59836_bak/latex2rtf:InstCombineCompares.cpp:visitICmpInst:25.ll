target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @CmdFontSeries(ptr %code.addr) {
entry:
  %true_code = alloca i32, align 4
  %0 = load i32, ptr %true_code, align 4
  %cmp7 = icmp eq i32 %0, 8
  %1 = load i32, ptr %true_code, align 4
  %cmp9 = icmp eq i32 %1, 9
  %or.cond = select i1 %cmp7, i1 true, i1 %cmp9
  br i1 %or.cond, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %2 = load i32, ptr %code.addr, align 4
  br label %if.end

if.end:                                           ; preds = %land.lhs.true, %entry
  ret void
}
