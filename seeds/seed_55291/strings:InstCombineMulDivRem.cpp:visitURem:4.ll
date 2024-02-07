target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal void @elf_x86_compute_dl_relr_bitmap(ptr %delta, i64 %0) {
entry:
  %delta1 = alloca i64, align 8
  br label %if.then

if.then:                                          ; preds = %entry
  br label %while.cond

while.cond:                                       ; preds = %if.then
  br label %while.body

while.body:                                       ; preds = %while.cond
  br label %if.end

if.end:                                           ; preds = %while.body
  br label %while.cond19

while.cond19:                                     ; preds = %if.end
  br label %while.body22

while.body22:                                     ; preds = %while.cond19
  br label %for.cond

for.cond:                                         ; preds = %while.body22
  br label %for.body

for.body:                                         ; preds = %for.cond
  br label %if.end31

if.end31:                                         ; preds = %for.body
  %1 = load i64, ptr %delta, align 8
  %rem32 = urem i64 %0, 8
  %cmp33 = icmp ne i64 %rem32, 0
  br i1 %cmp33, label %if.then35, label %if.end36

if.then35:                                        ; preds = %if.end31
  ret void

if.end36:                                         ; preds = %if.end31
  ret void
}
