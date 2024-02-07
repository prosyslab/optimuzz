target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb110

sw.bb110:                                         ; preds = %sw.bb110, %entry
  br label %sw.bb110

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
    i64 2066, label %return
    i64 2067, label %return
    i64 4106, label %return
    i64 4107, label %return
    i64 4114, label %return
    i64 4115, label %return
    i64 0, label %return
    i64 2063, label %return
    i64 2070, label %return
    i64 2071, label %return
    i64 4110, label %sw.bb73
    i64 4111, label %sw.bb73
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

sw.bb73:                                          ; preds = %land.rhs, %land.rhs
  store ptr @cpSeparateTiles2ContigTiles, ptr %retval, align 8
  br label %return

return:                                           ; preds = %sw.bb73, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %land.rhs, %entry
  ret ptr null
}

define internal i32 @cpSeparateTiles2ContigTiles() {
entry:
  %call = load i32, ptr @readSeparateTilesIntoBuffer, align 4
  ret i32 0
}

define internal i32 @readSeparateTilesIntoBuffer() {
entry:
  %in.addr = alloca ptr, align 8
  %tilew = alloca i32, align 4
  %0 = load i32, ptr %tilew, align 4
  %cmp = icmp ugt i32 1, %0
  br i1 %cmp, label %if.then, label %common.ret

common.ret:                                       ; preds = %if.then, %entry
  ret i32 0

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %in.addr, align 8
  br label %common.ret
}
