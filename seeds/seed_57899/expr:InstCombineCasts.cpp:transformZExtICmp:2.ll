target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call11 = call ptr @eval()
  ret i32 0
}

define internal ptr @eval() {
entry:
  %call = call ptr @eval1()
  ret ptr null
}

define internal ptr @eval1() {
entry:
  %call1 = call ptr @eval2(ptr null, i32 0)
  ret ptr null
}

define internal ptr @eval2(ptr %cmp, i32 %0) {
entry:
  %cmp52 = icmp slt i32 %0, 0
  %frombool53 = zext i1 %cmp52 to i8
  store i8 %frombool53, ptr %cmp, align 1
  ret ptr null
}
