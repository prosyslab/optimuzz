target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call108 = call i1 @head_file()
  ret i32 0
}

define internal i1 @head_file() {
entry:
  %call13 = call i1 @head()
  ret i1 false
}

define internal i1 @head() {
entry:
  %call201 = call i1 @elide_tail_bytes_file(ptr null, i64 0)
  ret i1 false
}

define internal i1 @elide_tail_bytes_file(ptr %bytes_remaining, i64 %0) {
entry:
  %cmp7 = icmp slt i64 %0, 0
  %cond11 = select i1 %cmp7, i64 0, i64 %0
  store i64 %cond11, ptr %bytes_remaining, align 8
  ret i1 false
}
