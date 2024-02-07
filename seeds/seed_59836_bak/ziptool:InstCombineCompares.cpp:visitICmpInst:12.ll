target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dispatch_table_s = type { ptr, i32, ptr, ptr, ptr }
%struct.zip_stat = type { i64, ptr, i64, i64, i64, i64, i32, i16, i16, i32 }

@.str.33 = external constant [1 x i8]
@dispatch_table = global [32 x %struct.dispatch_table_s] [%struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 5, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 0, ptr @.str.33, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 0, ptr @.str.33, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 5, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr @zstat }]

define internal i32 @zstat() {
entry:
  %sb = alloca %struct.zip_stat, align 8
  %0 = load i64, ptr %sb, align 8
  %tobool = icmp ne i64 %0, 0
  br i1 %tobool, label %if.then4, label %if.end7

if.then4:                                         ; preds = %entry
  %name = getelementptr %struct.zip_stat, ptr %sb, i32 0, i32 1
  br label %if.end7

if.end7:                                          ; preds = %if.then4, %entry
  ret i32 0
}

; uselistorder directives
uselistorder ptr null, { 0, 1, 2, 3, 4, 5, 21, 12, 20, 14, 22, 7, 16, 19, 23, 6, 18, 9, 24, 11, 15, 10, 25, 13, 8, 17 }
