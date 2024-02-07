target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call4 = call i1 @posixtest()
  ret i32 0
}

define internal i1 @posixtest() {
entry:
  %call5 = call i1 @three_arguments()
  ret i1 false
}

define internal i1 @three_arguments() {
entry:
  %call11 = call i1 @binary_operator(ptr null, i1 false, i8 0)
  ret i1 false
}

define internal i1 @binary_operator(ptr %cmp98, i1 %cmp133, i8 %0) {
entry:
  %conv134 = zext i1 %cmp133 to i32
  %tobool135 = trunc i8 %0 to i1
  %conv136 = zext i1 %tobool135 to i32
  %cmp137 = icmp eq i32 %conv134, %conv136
  store i1 %cmp137, ptr %cmp98, align 1
  ret i1 false
}
