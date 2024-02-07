target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #0

define internal void @duk_hobject_pc2line_pack(ptr %curr_pc, i64 %0) {
entry:
  %curr_pc1 = alloca i64, align 8
  br label %do.body

do.body:                                          ; preds = %entry
  br label %do.end

do.end:                                           ; preds = %do.body
  br label %do.body4

do.body4:                                         ; preds = %do.end
  br label %do.end5

do.end5:                                          ; preds = %do.body4
  br label %do.body6

do.body6:                                         ; preds = %do.end5
  br label %do.end7

do.end7:                                          ; preds = %do.body6
  br label %while.cond

while.cond:                                       ; preds = %do.end7
  br label %while.body

while.body:                                       ; preds = %while.cond
  br label %do.body11

do.body11:                                        ; preds = %while.body
  br label %do.end12

do.end12:                                         ; preds = %do.body11
  br label %do.body13

do.body13:                                        ; preds = %do.end12
  br label %do.end14

do.end14:                                         ; preds = %do.body13
  br label %do.body26

do.body26:                                        ; preds = %do.end14
  br label %do.body27

do.body27:                                        ; preds = %do.body26
  br label %do.end28

do.end28:                                         ; preds = %do.body27
  br label %do.end29

do.end29:                                         ; preds = %do.end28
  br label %for.cond

for.cond:                                         ; preds = %do.end29
  %1 = load i64, ptr %curr_pc, align 8
  %rem = urem i64 %0, 64
  %cmp31 = icmp eq i64 %rem, 0
  br i1 %cmp31, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %for.cond
  br label %if.then

if.then:                                          ; preds = %lor.lhs.false, %for.cond
  ret void
}

attributes #0 = { argmemonly nofree nounwind willreturn writeonly }
