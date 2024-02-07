target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @strchr(ptr, i32)

define i32 @main() {
entry:
  ret i32 0

if.end204:                                        ; No predecessors!
  %call2051 = call i32 @writeCroppedImage(ptr null)
  unreachable
}

define internal i32 @writeCroppedImage(ptr %cp) {
entry:
  %cp1 = alloca ptr, align 8
  br label %while.cond

while.cond:                                       ; preds = %if.then256, %while.cond, %entry
  %call254 = call ptr @strchr(ptr null, i32 0)
  store ptr %call254, ptr %cp1, align 8
  %0 = load ptr, ptr %cp1, align 8
  %tobool255 = icmp ne ptr %0, null
  br i1 %tobool255, label %if.then256, label %while.cond

if.then256:                                       ; preds = %while.cond
  %1 = load ptr, ptr %cp, align 8
  br label %while.cond
}
