target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #0

define i32 @pngx_read_pnm(ptr %i, i32 %0) {
entry:
  %i1 = alloca i32, align 4
  br label %if.end

if.end:                                           ; preds = %entry
  br label %if.end8

if.end8:                                          ; preds = %if.end
  br label %if.end11

if.end11:                                         ; preds = %if.end8
  br label %if.end14

if.end14:                                         ; preds = %if.end11
  br label %if.else

if.else:                                          ; preds = %if.end14
  br label %if.end22

if.end22:                                         ; preds = %if.else
  br label %if.end23

if.end23:                                         ; preds = %if.end22
  br label %for.cond

for.cond:                                         ; preds = %if.end23
  br label %for.end

for.end:                                          ; preds = %for.cond
  br label %if.else35

if.else35:                                        ; preds = %for.end
  %1 = load i32, ptr %i, align 4
  %rem = urem i32 %0, 8
  %cmp36 = icmp ne i32 %rem, 0
  br i1 %cmp36, label %land.lhs.true, label %if.end45

land.lhs.true:                                    ; preds = %if.else35
  ret i32 0

if.end45:                                         ; preds = %if.else35
  ret i32 0
}

attributes #0 = { argmemonly nofree nounwind willreturn writeonly }
