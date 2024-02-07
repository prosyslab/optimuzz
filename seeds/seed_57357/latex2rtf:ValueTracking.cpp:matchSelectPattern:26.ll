target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.GraphConvertElement = type { ptr, ptr }

@GraphConvertTable = global [13 x %struct.GraphConvertElement] [%struct.GraphConvertElement zeroinitializer, %struct.GraphConvertElement zeroinitializer, %struct.GraphConvertElement zeroinitializer, %struct.GraphConvertElement zeroinitializer, %struct.GraphConvertElement zeroinitializer, %struct.GraphConvertElement zeroinitializer, %struct.GraphConvertElement zeroinitializer, %struct.GraphConvertElement zeroinitializer, %struct.GraphConvertElement zeroinitializer, %struct.GraphConvertElement zeroinitializer, %struct.GraphConvertElement zeroinitializer, %struct.GraphConvertElement { ptr null, ptr @PutWmfFile }, %struct.GraphConvertElement zeroinitializer]

define internal void @PutWmfFile() {
entry:
  %Bottom = alloca i16, align 2
  %height = alloca i16, align 2
  %0 = load i16, ptr %Bottom, align 2
  %conv76 = zext i16 %0 to i32
  %sub77 = sub nsw i32 0, %conv76
  %call78 = call i32 @abs(i32 %sub77)
  %conv79 = trunc i32 %call78 to i16
  store i16 %conv79, ptr %height, align 2
  %1 = load i16, ptr %height, align 2
  %conv127 = uitofp i16 %1 to double
  call void @AdjustScaling(double %conv127)
  ret void
}

declare i32 @abs(i32)

declare void @AdjustScaling(double)
