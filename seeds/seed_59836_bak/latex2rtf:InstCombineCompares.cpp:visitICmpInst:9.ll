target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@startParagraph.the_style = internal global [50 x i8] c"Normal\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00"
@.str.49.3670 = private constant [8 x i8] c"acronym\00"

declare i32 @strcmp(ptr, ptr)

define void @startParagraph(ptr %width) {
entry:
  %call101 = call i32 @strcmp(ptr @startParagraph.the_style, ptr @.str.49.3670)
  %cmp102 = icmp eq i32 %call101, 0
  br i1 %cmp102, label %if.then104, label %if.end106

if.then104:                                       ; preds = %entry
  %0 = load i32, ptr %width, align 4
  br label %if.end106

if.end106:                                        ; preds = %if.then104, %entry
  ret void
}
