target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@compression = external global i16

define i32 @main() {
entry:
  ret i32 0

if.end204:                                        ; No predecessors!
  %call2051 = call i32 @writeCroppedImage(ptr null)
  unreachable
}

define internal i32 @writeCroppedImage(ptr %out.addr) {
entry:
  %0 = load i16, ptr @compression, align 2
  %conv50 = zext i16 %0 to i32
  %cmp51 = icmp eq i32 %conv50, 34676
  br i1 %cmp51, label %if.then57, label %lor.lhs.false53

lor.lhs.false53:                                  ; preds = %entry
  %1 = load i16, ptr @compression, align 2
  %conv54 = zext i16 %1 to i32
  %cmp55 = icmp eq i32 %conv54, 34677
  br i1 %cmp55, label %if.then57, label %common.ret

common.ret:                                       ; preds = %if.then57, %lor.lhs.false53
  ret i32 0

if.then57:                                        ; preds = %lor.lhs.false53, %entry
  %2 = load ptr, ptr %out.addr, align 8
  br label %common.ret
}
