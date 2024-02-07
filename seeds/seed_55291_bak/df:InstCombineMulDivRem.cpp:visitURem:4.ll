target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @gettext()

define i32 @main() {
if.end184:
  call void @get_header(ptr undef, i64 undef, ptr undef, i8 undef, i1 undef, i32 undef, i32 undef, i1 undef)
  ret i32 0
}

; Function Attrs: convergent nocallback nofree nosync nounwind readnone willreturn
declare i1 @llvm.is.constant.i32(i32) #0

define internal void @get_header(ptr %q1024, i64 %0, ptr %divisible_by_1024, i8 %1, i1 %tobool13, i32 %conv14, i32 %and15, i1 %tobool16) {
entry:
  %q10241 = alloca i64, align 8
  %divisible_by_10242 = alloca i8, align 1
  br label %for.cond

for.cond:                                         ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.cond
  br label %land.lhs.true

land.lhs.true:                                    ; preds = %for.body
  br label %if.then

if.then:                                          ; preds = %land.lhs.true
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.then
  %2 = load i64, ptr %q1024, align 8
  %rem8 = urem i64 %0, 1024
  %cmp9 = icmp eq i64 %rem8, 0
  %frombool10 = zext i1 %cmp9 to i8
  store i8 %frombool10, ptr %q1024, align 1
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %3 = load i8, ptr undef, align 1
  %tobool12 = trunc i8 1 to i1
  %conv = zext i1 true to i32
  %4 = load i8, ptr %q1024, align 1
  %tobool133 = trunc i8 %1 to i1
  %conv144 = zext i1 %tobool13 to i32
  %and155 = and i32 1, %conv14
  %tobool166 = icmp ne i32 %conv14, 0
  br i1 %tobool13, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  ret void
}

declare void @alloc_table_row()

attributes #0 = { convergent nocallback nofree nosync nounwind readnone willreturn }
