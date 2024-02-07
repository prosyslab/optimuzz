target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._mode_module = type { ptr, ptr, ptr, ptr, i32, ptr, ptr }

@mode_cmp = global %struct._mode_module { ptr null, ptr null, ptr null, ptr null, i32 0, ptr @cmp_main, ptr null }

define internal i32 @cmp_main() {
entry:
  %call = call i32 @process.728()
  ret i32 0
}

define internal i32 @process.728() {
entry:
  %call3 = call i32 @process_files()
  ret i32 0
}

define internal i32 @process_files() {
entry:
  %call6 = call i32 @shift_comparison()
  ret i32 0
}

define internal i32 @shift_comparison() {
entry:
  %call7411 = call i32 @cmp_files(ptr null, i32 0)
  ret i32 0
}

define internal i32 @cmp_files(ptr %shift.addr, i32 %0) {
entry:
  %cmp11 = icmp slt i32 %0, 0
  %1 = load i32, ptr %shift.addr, align 4
  %sub = sub nsw i32 0, %1
  %cond15 = select i1 %cmp11, i32 %sub, i32 %1
  store i32 %cond15, ptr %shift.addr, align 4
  ret i32 0
}
