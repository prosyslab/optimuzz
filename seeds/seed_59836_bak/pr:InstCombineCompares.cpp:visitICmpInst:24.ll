target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.COLUMN = type { ptr, ptr, i32, ptr, ptr, i32, i32, i32, i32, i8, i8 }

define i32 @main() {
entry:
  unreachable

if.then173:                                       ; No predecessors!
  call void @print_files()
  unreachable
}

define internal void @print_files() {
entry:
  %call91 = call i1 @print_page(i32 0)
  ret void
}

define internal i1 @print_page(i32 %0) {
entry:
  %lines_to_print201 = getelementptr %struct.COLUMN, ptr undef, i32 0, i32 7
  %dec = add nsw i32 %0, 1
  store i32 %dec, ptr %lines_to_print201, align 8
  %1 = load i32, ptr undef, align 8
  %cmp22 = icmp sle i32 %1, 0
  br i1 %cmp22, label %if.then24, label %common.ret

common.ret:                                       ; preds = %if.then24, %entry
  ret i1 false

if.then24:                                        ; preds = %entry
  %call25 = call i32 @cols_ready_to_print()
  br label %common.ret
}

declare i32 @cols_ready_to_print()
