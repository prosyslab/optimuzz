target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ImportID3v2() {
entry:
  br label %return

if.end33:                                         ; No predecessors!
  %call421 = call i32 @ImportID3v2_syncsafe(ptr null, i8 0)
  br label %return

return:                                           ; preds = %if.end33, %entry
  ret i32 0
}

define internal i32 @ImportID3v2_syncsafe(ptr %frame_header, i8 %0) {
entry:
  %conv113 = zext i8 %0 to i32
  %cmp114 = icmp slt i32 %conv113, 1
  br i1 %cmp114, label %if.then134, label %lor.lhs.false116

lor.lhs.false116:                                 ; preds = %entry
  %1 = load i32, ptr %frame_header, align 4
  br label %if.then134

if.then134:                                       ; preds = %lor.lhs.false116, %entry
  ret i32 0
}
