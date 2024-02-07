target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal void @mtree_quote(ptr %c, i8 %0) {
entry:
  %c1 = alloca i8, align 1
  br label %for.cond

for.cond:                                         ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.cond
  br label %if.end

if.end:                                           ; preds = %for.body
  br label %if.end5

if.end5:                                          ; preds = %if.end
  %1 = load i8, ptr %c, align 1
  %conv15 = zext i8 %0 to i32
  %rem16 = srem i32 %conv15, 8
  %add17 = add nsw i32 8, 0
  %conv18 = trunc i32 %rem16 to i8
  store i8 %conv18, ptr undef, align 1
  ret void
}
