target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @printTIF() {
entry:
  ret void

if.then12:                                        ; No predecessors!
  %call108 = call i32 (ptr, i32, ...) @TIFFSetField(ptr null, i32 0, ptr @printruns)
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %if.then12
  br label %for.cond
}

define internal void @printruns() {
entry:
  %colormode = alloca i32, align 4
  %runlength = alloca i32, align 4
  %0 = load i32, ptr %runlength, align 4
  %cmp1 = icmp ule i32 %0, 0
  br i1 %cmp1, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret void

if.then:                                          ; preds = %entry
  %1 = load i32, ptr %colormode, align 4
  br label %common.ret
}

declare i32 @TIFFSetField(ptr, i32, ...)
