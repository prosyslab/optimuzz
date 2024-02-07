target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call2051 = call i32 @writeCroppedImage(i32 0, ptr null)
  ret i32 0
}

define internal i32 @writeCroppedImage(i32 %conv92, ptr %compression) {
entry:
  %input_photometric = alloca i16, align 2
  %0 = load i16, ptr %input_photometric, align 2
  %conv84 = zext i16 %0 to i32
  %cmp85 = icmp eq i32 %conv84, 32844
  br i1 %cmp85, label %land.lhs.true91, label %lor.lhs.false87

lor.lhs.false87:                                  ; preds = %entry
  %1 = load i16, ptr %input_photometric, align 2
  %conv88 = zext i16 %1 to i32
  %cmp89 = icmp eq i32 %conv88, 32845
  br i1 %cmp89, label %land.lhs.true91, label %if.end100

land.lhs.true91:                                  ; preds = %lor.lhs.false87, %entry
  %cmp93 = icmp ne i32 %conv92, 0
  br i1 %cmp93, label %land.lhs.true95, label %if.end100

land.lhs.true95:                                  ; preds = %land.lhs.true91
  %2 = load i16, ptr %compression, align 2
  br label %if.end100

if.end100:                                        ; preds = %land.lhs.true95, %land.lhs.true91, %lor.lhs.false87
  ret i32 0
}
