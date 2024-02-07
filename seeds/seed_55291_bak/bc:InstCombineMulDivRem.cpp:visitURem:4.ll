target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.program_counter = type { i32, i32 }
%struct.bc_label_group = type { [64 x i64], ptr }

@pc = external global %struct.program_counter

declare i8 @byte()

define void @execute(ptr %label_num, i64 %0, ptr %l_off, ptr %1, ptr %l_adrs, i64 %2, ptr %arrayidx53, i64 %3, i32 %conv54, ptr %4) {
entry:
  %label_num1 = alloca i64, align 8
  %l_off2 = alloca i64, align 8
  br label %if.end

if.end:                                           ; preds = %entry
  br label %while.cond

while.cond:                                       ; preds = %if.end
  br label %land.end

land.end:                                         ; preds = %while.cond
  br label %while.body

while.body:                                       ; preds = %land.end
  switch i32 0, label %sw.default502 [
    i32 0, label %sw.bb21
  ]

sw.bb21:                                          ; preds = %while.body
  br label %if.then44

if.then44:                                        ; preds = %sw.bb21
  %5 = load i64, ptr %label_num, align 8
  %rem = urem i64 %0, 64
  store i64 %rem, ptr %label_num, align 8
  br label %while.cond47

while.cond47:                                     ; preds = %if.then44
  br label %while.end

while.end:                                        ; preds = %while.cond47
  br label %if.then52

if.then52:                                        ; preds = %while.end
  %6 = load ptr, ptr undef, align 8
  %l_adrs3 = getelementptr inbounds %struct.bc_label_group, ptr %1, i32 0, i32 0
  %7 = load i64, ptr %label_num, align 8
  %arrayidx534 = getelementptr inbounds [64 x i64], ptr %l_adrs, i64 0, i64 %2
  %8 = load i64, ptr %label_num, align 8
  %conv545 = trunc i64 %0 to i32
  store i32 %conv54, ptr %label_num, align 4
  ret void

sw.default502:                                    ; preds = %while.body
  ret void
}

declare void @bc_init_num()
