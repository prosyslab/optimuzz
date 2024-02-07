target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dispatch_table_s = type { ptr, i32, ptr, ptr, ptr }

@.str.33 = external constant [1 x i8]
@dispatch_table = global [32 x %struct.dispatch_table_s] [%struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 5, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 0, ptr @.str.33, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 0, ptr @.str.33, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 5, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr @zstat }]

define internal i32 @zstat() {
entry:
  %tpm = alloca ptr, align 8
  %0 = load ptr, ptr %tpm, align 8
  %cmp31 = icmp eq ptr %0, null
  br i1 %cmp31, label %if.then32, label %common.ret

common.ret:                                       ; preds = %if.then32, %entry
  ret i32 0

if.then32:                                        ; preds = %entry
  %call33 = call i32 (...) @printf()
  br label %common.ret
}

declare i32 @printf(...)

; uselistorder directives
uselistorder ptr null, { 0, 1, 2, 3, 4, 5, 6, 24, 16, 19, 20, 26, 13, 14, 11, 23, 17, 8, 10, 25, 12, 18, 7, 22, 9, 21, 15 }
