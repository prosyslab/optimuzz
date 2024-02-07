target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.395 = private constant [2 x i8] c".\00"

declare i32 @strcmp(ptr, ptr)

define i32 @mapname(ptr %pathcomp) {
entry:
  %pathcomp1 = alloca [4096 x i8], align 16
  %call23 = call i32 @strcmp(ptr %pathcomp1, ptr @.str.395)
  %cmp24 = icmp eq i32 %call23, 0
  br i1 %cmp24, label %if.then26, label %common.ret

common.ret:                                       ; preds = %if.then26, %entry
  ret i32 0

if.then26:                                        ; preds = %entry
  %arraydecay27 = getelementptr [4096 x i8], ptr %pathcomp, i64 0, i64 0
  br label %common.ret
}
