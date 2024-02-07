target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @dlang_demangle() {
entry:
  br label %return

if.else:                                          ; No predecessors!
  %call13 = call ptr @dlang_parse_mangle()
  br label %return

return:                                           ; preds = %if.else, %entry
  ret ptr null
}

define internal ptr @dlang_parse_mangle() {
entry:
  %call = call ptr @dlang_parse_qualified()
  ret ptr null
}

define internal ptr @dlang_parse_qualified() {
entry:
  br label %do.body2

do.body2:                                         ; preds = %if.then6, %do.body2, %entry
  br label %do.body2

if.then6:                                         ; No predecessors!
  %call1 = call ptr @dlang_identifier(ptr null, ptr null, i64 0)
  br label %do.body2
}

define internal ptr @dlang_identifier(ptr %numptr, ptr %0, i64 %1) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %land.rhs, %while.cond, %entry
  %2 = load ptr, ptr %numptr, align 8
  %add.ptr84 = getelementptr i8, ptr %0, i64 %1
  %cmp85 = icmp ult ptr %2, %add.ptr84
  br i1 %cmp85, label %land.rhs, label %while.cond

land.rhs:                                         ; preds = %while.cond
  %3 = load ptr, ptr %numptr, align 8
  br label %while.cond
}
