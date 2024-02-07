target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @sha256_start()

declare void @sha256_update()

declare void @sha256_finish()

define void @sha2_seed(ptr %i, i32 %0, i64 %conv7, ptr %sha256sum, ptr %arrayidx10) {
entry:
  %i1 = alloca i32, align 4
  %sha256sum2 = alloca [32 x i8], align 16
  br label %for.cond

for.cond:                                         ; preds = %entry
  br label %for.end

for.end:                                          ; preds = %for.cond
  br label %for.cond3

for.cond3:                                        ; preds = %for.inc11, %for.end
  br label %for.body6

for.body6:                                        ; preds = %for.cond3
  %1 = load i32, ptr %i, align 4
  %conv73 = sext i32 %0 to i64
  %rem = urem i64 %conv7, 32
  %arrayidx8 = getelementptr inbounds [32 x i8], ptr %sha256sum, i64 0, i64 %rem
  %2 = load i8, ptr %arrayidx8, align 1
  %arrayidx104 = getelementptr inbounds i8, ptr undef, i64 undef
  store i8 %2, ptr %i, align 1
  br label %for.inc11

for.inc11:                                        ; preds = %for.body6
  br label %for.cond3
}

declare i32 @get_some_time()

declare void @srand()
