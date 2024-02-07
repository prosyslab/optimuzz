target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.then:                                          ; No predecessors!
  %call105 = call i32 @dd_copy()
  ret i32 0
}

define internal i32 @dd_copy() {
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  br label %do.body

if.end48:                                         ; No predecessors!
  call void @alloc_ibuf(ptr null, i32 0)
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %if.end48
  br label %for.cond
}

define internal void @alloc_ibuf(ptr %conversions_mask, i32 %0) {
entry:
  %and = and i32 %0, 128
  %tobool1 = icmp ne i32 %and, 0
  %frombool = zext i1 %tobool1 to i8
  store i8 %frombool, ptr %conversions_mask, align 1
  %1 = load i8, ptr %conversions_mask, align 1
  %tobool3 = trunc i8 %1 to i1
  %conv = zext i1 %tobool3 to i64
  %call = call ptr @alignalloc(i64 %conv)
  ret void
}

declare ptr @alignalloc(i64)
