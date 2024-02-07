target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  store i32 0, ptr @print_text_marker, align 4
  ret i32 0
}

define internal i32 @print_text_marker() align 4 {
entry:
  %cinfo.addr = alloca ptr, align 8
  %traceit = alloca i32, align 4
  %0 = load i32, ptr %cinfo.addr, align 4
  %cmp = icmp sge i32 %0, 0
  %conv = zext i1 %cmp to i32
  store i32 %conv, ptr %traceit, align 4
  %1 = load i32, ptr %traceit, align 4
  %tobool = icmp ne i32 %1, 0
  br i1 %tobool, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %2 = load ptr, ptr %cinfo.addr, align 8
  br label %common.ret
}
