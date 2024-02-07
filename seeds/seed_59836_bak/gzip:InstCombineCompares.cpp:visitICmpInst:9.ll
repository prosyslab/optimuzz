target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.92 = private constant [5 x i8] c"PK\03\04\00"
@inbuf = global [262208 x i8] zeroinitializer

define i32 @main() {
entry:
  unreachable

if.then135:                                       ; No predecessors!
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %if.then135
  call void @treat_file()
  br label %while.cond
}

define internal void @treat_file() {
entry:
  br label %if.end243

if.then96:                                        ; No predecessors!
  %call1061 = call i32 @get_method(ptr null)
  br label %if.end243

if.end243:                                        ; preds = %if.then96, %entry
  ret void
}

define internal i32 @get_method(ptr %inptr) {
entry:
  %call404 = call i32 @memcmp(ptr @inbuf, ptr @.str.92, i64 4)
  %cmp405 = icmp eq i32 %call404, 0
  br i1 %cmp405, label %if.then407, label %common.ret

common.ret:                                       ; preds = %if.then407, %entry
  ret i32 0

if.then407:                                       ; preds = %entry
  store i32 0, ptr %inptr, align 4
  br label %common.ret
}

declare i32 @memcmp(ptr, ptr, i64)
