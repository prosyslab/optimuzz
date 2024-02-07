target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %call221 = call i32 @readMovieHeader(ptr null, i64 0)
  ret i32 0
}

define internal i32 @readMovieHeader(ptr %stat_buf, i64 %0) {
entry:
  %cmp45 = icmp ne i64 0, %0
  br i1 %cmp45, label %if.then47, label %common.ret

common.ret:                                       ; preds = %if.then47, %entry
  ret i32 0

if.then47:                                        ; preds = %entry
  %1 = load ptr, ptr %stat_buf, align 8
  br label %common.ret
}
