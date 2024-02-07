target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @Ascii85Put() {
entry:
  %call1 = call ptr @Ascii85Encode(ptr null, i32 0)
  ret void
}

define internal ptr @Ascii85Encode(ptr %word, i32 %0) {
entry:
  %conv11 = zext i32 %0 to i64
  %cmp = icmp ne i64 %conv11, 0
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret ptr null

if.then:                                          ; preds = %entry
  %1 = load i32, ptr %word, align 4
  br label %common.ret
}
