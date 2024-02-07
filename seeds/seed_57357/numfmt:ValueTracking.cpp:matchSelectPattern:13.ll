target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call163 = call i32 @process_line()
  ret i32 0
}

define internal i32 @process_line() {
entry:
  %call2 = call i1 @process_field()
  ret i32 0
}

define internal i1 @process_field() {
entry:
  %call4 = call i32 @prepare_padded_number()
  ret i1 false
}

define internal i32 @prepare_padded_number() {
entry:
  %call1 = call x86_fp80 @expld(ptr null, x86_fp80 0xK00000000000000000000, i1 false)
  ret i32 0
}

define internal x86_fp80 @expld(ptr %val.addr, x86_fp80 %0, i1 %cmp1) {
entry:
  %cmp = fcmp oge x86_fp80 %0, 0xK3FFF8000000000000000
  %or.cond = select i1 %cmp, i1 %cmp1, i1 false
  br i1 %or.cond, label %while.cond, label %if.end

while.cond:                                       ; preds = %entry
  %1 = load x86_fp80, ptr %val.addr, align 16
  br label %if.end

if.end:                                           ; preds = %while.cond, %entry
  ret x86_fp80 0xK00000000000000000000
}
