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
  %runs.addr = alloca ptr, align 8
  %runlength = alloca i32, align 4
  %bitsleft = alloca i32, align 4
  %0 = load i32, ptr %runlength, align 4
  %sub54 = sub i32 1, %0
  store i32 %sub54, ptr %bitsleft, align 4
  %1 = load i32, ptr %bitsleft, align 4
  %tobool55 = icmp ne i32 %1, 0
  br i1 %tobool55, label %if.then56, label %common.ret

common.ret:                                       ; preds = %if.then56, %entry
  ret void

if.then56:                                        ; preds = %entry
  %2 = load ptr, ptr %runs.addr, align 8
  br label %common.ret
}

declare i32 @TIFFSetField(ptr, i32, ...)
