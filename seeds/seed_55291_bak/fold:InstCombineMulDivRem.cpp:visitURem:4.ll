target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.13 = external dso_local constant [2 x i8]

define i32 @main() {
if.then16:
  %call17 = call i1 @fold_file()
  ret i32 0
}

define internal i1 @fold_file() {
rescan:
  %call181 = call i64 @adjust_column(ptr undef, i64 undef)
  ret i1 false
}

define internal i64 @adjust_column(ptr %column.addr, i64 %0) {
entry:
  %column.addr1 = alloca i64, align 8
  br label %if.then

if.then:                                          ; preds = %entry
  br label %if.else

if.else:                                          ; preds = %if.then
  br label %if.else10

if.else10:                                        ; preds = %if.else
  br label %if.then14

if.then14:                                        ; preds = %if.else10
  %1 = load i64, ptr %column.addr, align 8
  %rem = urem i64 %0, 8
  %sub = sub i64 0, 8
  %2 = load i64, ptr undef, align 8
  %add = add i64 0, 0
  store i64 %rem, ptr %column.addr, align 8
  ret i64 0
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memmove.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1 immarg) #0

attributes #0 = { argmemonly nofree nounwind willreturn }
