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
  %call13612 = call i32 @yy_get_next_buffer(ptr null, i32 0, ptr null)
  switch i32 0, label %while.cond21 [
    i32 1, label %sw.bb
    i32 0, label %while.cond21
    i32 2, label %sw.bb
  ]
}

define internal i32 @yy_get_next_buffer(ptr %b, i32 %0, ptr %new_size) {
entry:
  %mul = mul nsw i32 %0, 2
  store i32 %mul, ptr %new_size, align 4
  %1 = load i32, ptr %new_size, align 4
  %cmp36 = icmp sle i32 %1, 0
  br i1 %cmp36, label %if.then38, label %common.ret

common.ret:                                       ; preds = %if.then38, %entry
  ret i32 0

if.then38:                                        ; preds = %entry
  %2 = load ptr, ptr %b, align 8
  br label %common.ret
}
