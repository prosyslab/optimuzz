target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @yylex() {
entry:
  br label %while.cond21

while.cond21:                                     ; preds = %if.else135, %if.else135, %while.cond21, %entry
  br label %while.cond21

sw.bb:                                            ; preds = %if.else135, %if.else135, %sw.bb
  br label %sw.bb

if.else135:                                       ; No predecessors!
  %call13612 = call i32 @yy_get_next_buffer(ptr null)
  switch i32 0, label %while.cond21 [
    i32 1, label %sw.bb
    i32 0, label %while.cond21
    i32 2, label %sw.bb
  ]
}

define internal i32 @yy_get_next_buffer(ptr %num_to_read) {
entry:
  %0 = load i32, ptr %num_to_read, align 4
  %cmp65 = icmp sgt i32 %0, 8192
  %spec.store.select = select i1 %cmp65, i32 8192, i32 %0
  store i32 %spec.store.select, ptr %num_to_read, align 4
  ret i32 0
}
