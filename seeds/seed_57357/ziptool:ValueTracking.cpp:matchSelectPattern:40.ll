target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dispatch_table_s = type { ptr, i32, ptr, ptr, ptr }

@.str.33 = external constant [1 x i8]
@dispatch_table = global [32 x %struct.dispatch_table_s] [%struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 5, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 0, ptr @.str.33, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 0, ptr @.str.33, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 5, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr @zstat }]

define internal i32 @zstat() {
entry:
  %idx = alloca i64, align 8
  %call1 = call i32 @zip_stat_index()
  %cmp = icmp slt i32 %call1, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = load i64, ptr %idx, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i32 0
}

declare i32 @zip_stat_index()

; uselistorder directives
uselistorder ptr null, { 0, 1, 2, 3, 4, 5, 21, 6, 7, 8, 22, 9, 10, 11, 23, 12, 13, 14, 24, 15, 16, 17, 25, 18, 19, 20 }
