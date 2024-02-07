target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.44 = external dso_local constant [6 x i8]
@spinner = external dso_local global [4 x i8]

define i32 @main() {
if.end46:
  call void @unzip()
  unreachable
}

define internal void @unzip() {
if.then70:
  call void @extract_stdout()
  ret void
}

define internal void @extract_stdout() {
if.end49:
  %call501 = call i32 @extract2fd(ptr undef, i32 undef, i32 undef, i64 undef, ptr undef)
  ret void
}

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #0

declare void @info(ptr, ...)

define internal i32 @extract2fd(ptr %n, i32 %0, i32 %div, i64 %conv, ptr %spinner) {
entry:
  %n1 = alloca i32, align 4
  br label %for.cond

for.cond:                                         ; preds = %entry
  br label %if.then

if.then:                                          ; preds = %for.cond
  br i1 true, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %if.then
  br i1 true, label %if.then2, label %if.end

if.then2:                                         ; preds = %land.lhs.true
  %1 = load i32, ptr %n, align 4
  %div2 = sdiv i32 %0, 1
  %conv3 = sext i32 %0 to i64
  %rem3 = urem i64 %conv, 4
  %arrayidx = getelementptr inbounds [4 x i8], ptr %spinner, i64 0, i64 %rem3
  %2 = load i8, ptr %arrayidx, align 1
  %conv4 = sext i8 %2 to i32
  call void (ptr, ...) @info(ptr null, i32 %conv4)
  br label %if.end

if.end:                                           ; preds = %if.then2, %land.lhs.true, %if.then
  ret i32 0
}

declare i64 @archive_read_data()

attributes #0 = { argmemonly nofree nounwind willreturn writeonly }
