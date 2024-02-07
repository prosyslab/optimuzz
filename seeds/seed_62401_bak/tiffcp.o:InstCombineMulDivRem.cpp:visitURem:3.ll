target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb102

sw.bb102:                                         ; preds = %sw.bb102, %entry
  br label %sw.bb102

if.end151:                                        ; No predecessors!
  br label %for.cond152

for.cond152:                                      ; preds = %for.cond152, %if.end151
  %call153 = call i32 @tiffcp()
  br label %for.cond152
}

define internal i32 @tiffcp() {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  br label %while.cond

for.inc:                                          ; No predecessors!
  %call3931 = call ptr @pickCopyFunc(ptr null)
  ret i32 0
}

define internal ptr @pickCopyFunc(ptr %retval) {
entry:
  br label %return

land.rhs:                                         ; No predecessors!
  switch i64 0, label %return [
    i64 1, label %return
    i64 2059, label %return
    i64 2066, label %sw.bb68
    i64 2067, label %sw.bb68
    i64 4106, label %return
    i64 4107, label %return
    i64 4114, label %return
    i64 4115, label %return
    i64 2062, label %return
    i64 2063, label %return
    i64 2070, label %return
    i64 2071, label %return
    i64 4110, label %return
    i64 0, label %return
    i64 4118, label %return
    i64 4119, label %return
    i64 2060, label %return
    i64 2061, label %return
    i64 2068, label %return
    i64 2069, label %return
    i64 4108, label %return
    i64 4109, label %return
    i64 4116, label %return
    i64 4117, label %return
    i64 2056, label %return
    i64 2057, label %return
    i64 2064, label %return
    i64 2065, label %return
    i64 4104, label %return
    i64 4105, label %return
    i64 4112, label %return
    i64 4113, label %return
  ]

sw.bb68:                                          ; preds = %land.rhs, %land.rhs
  store ptr @cpContigStrips2SeparateTiles, ptr %retval, align 8
  br label %return

return:                                           ; preds = %sw.bb68, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %entry
  ret ptr null
}

define internal i32 @cpContigStrips2SeparateTiles() {
entry:
  %call = load i32, ptr @writeBufferToSeparateTiles, align 4
  ret i32 0
}

define internal i32 @writeBufferToSeparateTiles() {
entry:
  %out.addr = alloca ptr, align 8
  %bps = alloca i16, align 2
  %0 = load i16, ptr %bps, align 2
  %conv20 = zext i16 %0 to i32
  %rem = srem i32 %conv20, 8
  %cmp21 = icmp ne i32 %rem, 0
  br i1 %cmp21, label %if.then23, label %common.ret

common.ret:                                       ; preds = %if.then23, %entry
  ret i32 0

if.then23:                                        ; preds = %entry
  %1 = load ptr, ptr %out.addr, align 8
  br label %common.ret
}
