target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @t2p_write_pdf_pages(ptr %i, i32 %0, i32 %add16) {
entry:
  %i1 = alloca i32, align 4
  br label %for.cond

for.cond:                                         ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.cond
  br label %do.body

do.body:                                          ; preds = %for.body
  br label %if.else

if.else:                                          ; preds = %do.body
  br label %if.else6

if.else6:                                         ; preds = %if.else
  br label %do.end

do.end:                                           ; preds = %if.else6
  %1 = load i32, ptr %i, align 4
  %add162 = add i32 %0, 0
  %rem = urem i32 %0, 8
  %cmp17 = icmp eq i32 %rem, 0
  br i1 %cmp17, label %if.then19, label %if.end22

if.then19:                                        ; preds = %do.end
  br label %if.end22

if.end22:                                         ; preds = %if.then19, %do.end
  ret i64 0
}
