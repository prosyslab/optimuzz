target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @read_quant_tables(ptr %call) {
entry:
  %cmp = icmp eq ptr %call, null
  br i1 %cmp, label %if.then, label %while.cond.preheader

while.cond.preheader:                             ; preds = %entry
  %call262 = call fastcc i32 @read_text_integer()
  br label %if.then

if.then:                                          ; preds = %while.cond.preheader, %entry
  ret i32 0
}

declare fastcc i32 @read_text_integer()
