target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dispatch_table_s = type { ptr, i32, ptr, ptr, ptr }

@.str.33 = external constant [1 x i8]
@dispatch_table = global [32 x %struct.dispatch_table_s] [%struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 5, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 0, ptr @.str.33, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 4, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 0, ptr @.str.33, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 5, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 3, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 2, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr null }, %struct.dispatch_table_s { ptr null, i32 1, ptr null, ptr null, ptr @zstat }]

define internal i32 @zstat() {
entry:
  br label %return

if.then4:                                         ; No predecessors!
  %call51 = call ptr @encode_filename(ptr null, i8 0)
  br label %return

return:                                           ; preds = %if.then4, %entry
  ret i32 0
}

define internal ptr @encode_filename(ptr %s15, i8 %0) {
entry:
  %conv26 = zext i8 %0 to i32
  %cmp27 = icmp sge i32 %conv26, 1
  br i1 %cmp27, label %cond.true, label %common.ret

common.ret:                                       ; preds = %cond.true, %entry
  ret ptr null

cond.true:                                        ; preds = %entry
  %1 = load ptr, ptr %s15, align 8
  br label %common.ret
}

; uselistorder directives
uselistorder ptr null, { 0, 1, 2, 3, 4, 5, 6, 7, 24, 20, 19, 11, 27, 18, 22, 10, 25, 21, 17, 15, 26, 12, 9, 8, 23, 16, 14, 13 }
