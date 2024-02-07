target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yyparse() {
entry:
  br label %while.cond

if.then86:                                        ; No predecessors!
  switch i32 0, label %while.cond [
    i32 4, label %sw.bb
    i32 7, label %while.cond
    i32 1, label %while.cond
    i32 9, label %while.cond
    i32 10, label %while.cond
    i32 0, label %while.cond
    i32 12, label %while.cond
    i32 13, label %while.cond
    i32 14, label %while.cond
    i32 15, label %while.cond
    i32 16, label %while.cond
    i32 19, label %while.cond
    i32 20, label %while.cond
    i32 21, label %while.cond
    i32 23, label %while.cond
    i32 24, label %while.cond
    i32 25, label %while.cond
    i32 28, label %while.cond
    i32 29, label %while.cond
    i32 30, label %while.cond
    i32 31, label %while.cond
    i32 32, label %while.cond
    i32 33, label %while.cond
    i32 34, label %while.cond
    i32 35, label %while.cond
    i32 36, label %while.cond
    i32 37, label %while.cond
    i32 38, label %while.cond
    i32 39, label %while.cond
    i32 40, label %while.cond
    i32 41, label %while.cond
    i32 42, label %while.cond
    i32 43, label %while.cond
    i32 44, label %while.cond
    i32 45, label %while.cond
    i32 46, label %while.cond
    i32 47, label %while.cond
    i32 48, label %while.cond
    i32 49, label %while.cond
    i32 51, label %while.cond
    i32 52, label %while.cond
    i32 53, label %while.cond
    i32 54, label %while.cond
    i32 55, label %while.cond
    i32 56, label %while.cond
    i32 57, label %while.cond
    i32 58, label %while.cond
    i32 59, label %while.cond
    i32 60, label %while.cond
    i32 61, label %while.cond
    i32 62, label %while.cond
    i32 63, label %while.cond
    i32 64, label %while.cond
    i32 65, label %while.cond
    i32 66, label %while.cond
    i32 67, label %while.cond
    i32 68, label %while.cond
    i32 69, label %while.cond
    i32 70, label %while.cond
    i32 71, label %while.cond
    i32 72, label %while.cond
    i32 73, label %while.cond
    i32 74, label %while.cond
    i32 76, label %while.cond
    i32 77, label %while.cond
    i32 78, label %while.cond
    i32 79, label %while.cond
    i32 80, label %while.cond
    i32 81, label %while.cond
    i32 82, label %while.cond
    i32 86, label %while.cond
    i32 88, label %while.cond
    i32 89, label %while.cond
    i32 90, label %while.cond
    i32 91, label %while.cond
    i32 92, label %while.cond
  ]

sw.bb:                                            ; preds = %if.then86
  call void @debug_print_current_time(ptr null, i8 0, i1 false)
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %sw.bb, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %if.then86, %entry
  br label %while.cond
}

define internal void @debug_print_current_time(ptr %pc.addr, i8 %0, i1 %tobool7) {
entry:
  %conv = zext i1 %tobool7 to i32
  %tobool8 = trunc i8 %0 to i1
  %conv9 = zext i1 %tobool8 to i32
  %cmp = icmp ne i32 %conv, %conv9
  br i1 %cmp, label %if.then11, label %common.ret

common.ret:                                       ; preds = %if.then11, %entry
  ret void

if.then11:                                        ; preds = %entry
  %1 = load i8, ptr %pc.addr, align 1
  br label %common.ret
}
